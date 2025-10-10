//
//  HomeScreenViewModelImpl.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 26.09.2025.
//

import Foundation
import Combine

class HomeScreenViewModelImpl: HomeScreenViewModel {
    @Published var tasks: [Task]
    @Published var isTasksExist: Bool = false
    
    private let userDefaultsStorage = UserDefaultStorage.shared
    private let localStorageService =  LocalStorageService()
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        tasks = userDefaultsStorage.tasks
        userDefaultsStorage
            .$tasks
            .sink { [weak self] in
                self?.tasks = $0
                self?.isTasksExist = !$0.isEmpty
            }
            .store(in: &cancellables)
        
    }
    
    func getTasksViewModels() -> [RoundedTaskViewModelImpl] {
        var viewModels: [RoundedTaskViewModelImpl] = []
        for task in tasks {
            viewModels.append(.init(from: task))
        }
        return viewModels
    }
}

extension HomeScreenViewModelImpl {
    static var mock: HomeScreenViewModelImpl = {
        let viewModel = HomeScreenViewModelImpl()
        viewModel.tasks = Task.samplelist
        return viewModel
    }()
}
