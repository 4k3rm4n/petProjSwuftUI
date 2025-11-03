//
//  HomeScreenViewModelImpl.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 26.09.2025.
//

import Foundation
import Combine

//MARK: todo save tasks viewModels here mb?

class HomeScreenViewModelImpl: HomeScreenViewModel {
    private var tasks = CurrentValueSubject<[Task], Never>([])
    @Published var isTasksExist: Bool = false
    @Published var newTask: Task = Task()
    @Published var displayedTasksSetting: TaskStatusPickerHelper = .all
    @Published var tasksViewModels: [RoundedTaskViewModelImpl] = []
    
    private let notificationService = NotificationService()
    private let userDefaultsStorage = UserDefaultStorage.shared
    private let localStorageService =  LocalStorageService()
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        userDefaultsStorage
            .$tasks
            .sink { [weak self] in
                self?.newTask = Task()
                self?.tasks.send($0)
            }
            .store(in: &cancellables)
        
        tasks.eraseToAnyPublisher()
            .map {
                !$0.isEmpty
            }
            .assign(to: \.isTasksExist, on: self)
            .store(in: &cancellables)
        
        $displayedTasksSetting
            .combineLatest(tasks.eraseToAnyPublisher())
            .sink { [weak self] in
                guard let self else { return }
                switch $0.0 {
                case .all:
                    tasksViewModels = getTasksViewModels()
                case .completed:
                    tasksViewModels = getTasksViewModels().filter { $0.taskStatus == .completed }
                case .overdue:
                    tasksViewModels = getTasksViewModels().filter { $0.taskStatus == .overdue }
                case .active:
                    tasksViewModels = getTasksViewModels().filter { $0.taskStatus == .active }
                }
            }
            .store(in: &cancellables)
        
        notificationService.requestPermission()
    }
    
    private func getTasksViewModels() -> [RoundedTaskViewModelImpl] {
        var viewModels: [RoundedTaskViewModelImpl] = []
        for task in tasks.value {
            viewModels.append(.init(from: task))
        }
        return viewModels
    }
    
    func removeTask(with taskId: UUID) {
        do {
            try localStorageService.removeTask(with: taskId)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

extension HomeScreenViewModelImpl {
    static var mock: HomeScreenViewModelImpl = {
        let viewModel = HomeScreenViewModelImpl()
        viewModel.tasks.send(Task.samplelist)
        return viewModel
    }()
}
