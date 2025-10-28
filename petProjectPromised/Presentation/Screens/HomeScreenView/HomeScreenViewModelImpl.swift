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
    @Published var tasks: [Task]
    @Published var isTasksExist: Bool = false
    @Published var newTask: Task = Task()
    @Published var displayedTasksSetting: TaskStatusPickerHelper = .all
    
    private let notificationService = NotificationService()
    private let userDefaultsStorage = UserDefaultStorage.shared
    private let localStorageService =  LocalStorageService()
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        tasks = userDefaultsStorage.tasks
        userDefaultsStorage
            .$tasks
            .sink { [weak self] in
                self?.newTask = Task()
                self?.tasks = $0
                self?.isTasksExist = !$0.isEmpty
            }
            .store(in: &cancellables)
        
        notificationService.requestPermission()
    }
    
    func getTasksViewModels(displayedTasksSetting: TaskStatusPickerHelper) -> [RoundedTaskViewModelImpl] {
        var viewModels: [RoundedTaskViewModelImpl] = []
        if displayedTasksSetting == .all {
            for task in tasks {
                viewModels.append(.init(from: task))
            }
        } else {
            for task in tasks {
                if task.status.rawValue == displayedTasksSetting.rawValue { /// -------------------
                    viewModels.append(.init(from: task))
                }
            }
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
        viewModel.tasks = Task.samplelist
        return viewModel
    }()
}
