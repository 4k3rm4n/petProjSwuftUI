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
    func removeTask(with taskId: UUID)
}


struct HomeScreenView<ViewModel>: View where ViewModel: HomeScreenViewModel {
    //private let viewModel1 = AddTaskViewModelImpl()
    @ObservedObject var viewModel: ViewModel
    //@StateObject private var k = KeyboardResponder()
    
    @State private var showAddTaskSheet: Bool = false
    @State private var addTaskSheetHeight: CGFloat = .zero
    
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
                
                HStack {
                    Spacer()
                    
                    MainRoundedButton() {
                        showAddTaskSheet = true
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 44)
            }
        }
        .sheet(isPresented: $showAddTaskSheet) {
            AddTaskView(viewModel: AddTaskViewModelImpl())
                .overlay {
                    GeometryReader { geometry in
                        Color.clear
                            .preference(key: ChildHeightPreferenceKey.self, value: geometry.size.height)
                    }
                }
                .onPreferenceChange(ChildHeightPreferenceKey.self) { height in
                    addTaskSheetHeight = height
                }
                .presentationDragIndicator(.visible)
                .presentationDetents([.height(addTaskSheetHeight)])
        }
    }
    
    var tasks: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 24) {
                ForEach(viewModel.getTasksViewModels()) { taskViewModel in
                    ZStack {
                        HStack(alignment: .center) {
                            Spacer()
                            
                            // MARK: todo remove to seperate folder
                            Button {
                                withAnimation(.smooth) {
                                    viewModel.removeTask(with: taskViewModel.id)
                                }
                            } label: {
                                Image(systemName: "trash")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundStyle(taskViewModel.taskPriority.color())
                            }
                        }
                        .padding(.horizontal, 24)
                        
                        RoundedTaskView(viewModel: taskViewModel)
                    }
                }
            }
        }
        .padding(.top, 24)
    }
}

struct ChildHeightPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    HomeScreenView(viewModel: HomeScreenViewModelImpl.mock)
}
