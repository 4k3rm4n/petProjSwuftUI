//
//  ContentView.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 25.09.2025.
//

//MARK: to do - add feature to mark task as completed -
//MARK: to do - sort tasks by priority and date -
//MARK: to do - add settings to allow user to set up push alerts settings -
//MARK: to do - FIX ANIMATION WHILE CHOOSING THE OPTION IN PICKER ON HOME SCREEN VIEW -


import SwiftUI
import Combine
import RealmSwift

protocol HomeScreenViewModel: ObservableObject {
    var isTasksExist: Bool { get }
    var newTask: TaskDTO { get set }
    var displayedTasksSetting: TaskStatusPickerHelper { get set }
    var tasksViewModels: [RoundedTaskViewModelImpl] { get }
    
    func removeTask(with taskId: ObjectId)
}


struct HomeScreenView<ViewModel>: View where ViewModel: HomeScreenViewModel {
    @ObservedObject var viewModel: ViewModel
    @State private var showAddTaskSheet: Bool = false
    @State private var showAddDateTimeScreen: Bool = false
    @State private var addTaskSheetHeight: CGFloat = .zero
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                MainScreenHeaderView()
                
                Picker("Choose displayed tasks", selection: $viewModel.displayedTasksSetting) {
                    ForEach(TaskStatusPickerHelper.allCases, id: \.self) { status in
                        Text(status.rawValue).tag(status)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 10)
                
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
            AddTaskView(showAddTaskSheet: $showAddTaskSheet, showAddDateTimeScreen: $showAddDateTimeScreen, newTask: $viewModel.newTask)
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
        .fullScreenCover(isPresented: $showAddDateTimeScreen) {
            AddTimeScreenView(viewModel: AddTimeScreenViewModelImpl(from: viewModel.newTask))
        }
    }
    
    var tasks: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 24) {
                ForEach(viewModel.tasksViewModels, id: \.id) { taskViewModel in
                    ZStack {
                        HStack(alignment: .center) {
                            Spacer()
                            Button {
                                withAnimation(.smooth) {
                                    viewModel.removeTask(with: taskViewModel.id)
                                }
                            } label: {
                                Image(systemName: "trash")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .foregroundStyle(taskViewModel.taskPriority.color())
                            }
                        }
                        .padding(.horizontal, 24)
                        
                        RoundedTaskView(viewModel: taskViewModel)
                    }
                }
            }
        }
        .animation(.smooth, value: viewModel.displayedTasksSetting)
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
