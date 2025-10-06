//
//  ContentView.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 25.09.2025.
//

import SwiftUI
import Combine

protocol HomeScreenViewModel: ObservableObject {
    var tasks: [Task] { get }
    var isTasksExist: Bool { get }
    
    func getTasksViewModels() -> [RoundedTaskViewModelImpl]
}


struct HomeScreenView<ViewModel>: View where ViewModel: HomeScreenViewModel {
    @ObservedObject var viewModel: ViewModel
    @StateObject private var keyboardResponder = KeyboardResponder()
    
    @State private var showAddTaskSheet: Bool = false
    
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
            .padding(.top, 68)
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    MainRoundedButton() {
                        showAddTaskSheet = true
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 80)
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
                        .padding(.bottom, keyboardResponder.keyboardHeight)
                        .animation(.smooth, value: keyboardResponder.keyboardHeight)
                }
                .ignoresSafeArea(edges: .all)
                .transition(.move(edge: .bottom))
            }
        }
        .ignoresSafeArea(edges: .all)
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
