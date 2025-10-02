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
    
    @State private var showAddTaskSheet: Bool = false
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
                .onTapGesture {
                    showAddTaskSheet = false
                }
            
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
                
                HStack {
                    Spacer()
                    
                    MainRoundedButton() {
                        showAddTaskSheet = true
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 44)
            }
            
            
            if showAddTaskSheet {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture {
                        KeyboardOperations.hideKeyboard()
                        showAddTaskSheet = false
                    }
                    .transition(.opacity)
            }
            
            if showAddTaskSheet {
                VStack {
                    Spacer()
                    
                    AddTaskView(viewModel: AddTaskViewModelImpl())
                }
                //.ignoresSafeArea(edges: .bottom)
                .padding(.bottom, -34) 
                .transition(.move(edge: .bottom))
            }
        }
        .animation(.smooth, value: showAddTaskSheet)
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
