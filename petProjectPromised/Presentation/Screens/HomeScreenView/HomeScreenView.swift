//
//  ContentView.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 25.09.2025.
//

import SwiftUI

protocol HomeScreenViewModel: ObservableObject {
    var tasks: [Task] { get }
    var isTasksExist: Bool { get }
    
    func getTasksViewModels() -> [RoundedTaskViewModelImpl]
}
struct HomeScreenView<ViewModel>: View where ViewModel: HomeScreenViewModel {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack {
                MainScreenHeaderView()
                
                if viewModel.isTasksExist {
                    tasks
                } else {
                    EmptyTaskView()
                }
            }
            
            VStack {
                Spacer()
                
                HStack(alignment: .bottom) {
                    Spacer()
                    
                    MainRoundedButton() {
                        
                    }
                }
                .padding(.trailing, 24)
                .padding(.bottom, 44)
            }
        }
    }
    
    var tasks: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                ForEach(viewModel.getTasksViewModels()) { taskViewModel in
                    RoundedTaskView(viewModel: taskViewModel)
                }
            }
        }
        .padding(.top, 24)
        .padding(.horizontal, 16)
    }
}

#Preview {
    HomeScreenView(viewModel: HomeScreenViewModelImpl.mock)
}
