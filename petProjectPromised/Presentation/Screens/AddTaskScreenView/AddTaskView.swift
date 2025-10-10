//
//  AddTaskView.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 29.09.2025.
//

// MARK: TO DO VALIDATE() METHOD IN VIEWMODEL ------------------

import SwiftUI
import SwiftUICalendar

protocol AddTaskViewModel: ObservableObject {
    var taskNameText: String { get set }
    var taskDescriptionText: String { get set }
    var selectedPriority: TaskPriority { get set }
    var taskTillTime: Date { get set }
    var taskTillDate: YearMonthDay? { get set }
    var isSelectedTime: Bool { get set }
    var isSaveTaskButtonClicked: Bool { get set }
}

struct AddTaskView<ViewModel>: View where ViewModel: AddTaskViewModel{
    @ObservedObject var viewModel: ViewModel
    @State var isPresentedDatePickerScreen: Bool = false
    
    var body: some View {
            ZStack {
                Color.white
                
                VStack(spacing: 16) {
                    TextField("Task Name", text: $viewModel.taskNameText)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .background(Color(.white))
                        .padding(.horizontal, 4)
                        .cornerRadius(8)
                    
                    TextField("Description", text: $viewModel.taskDescriptionText)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .background(Color(.white))
                        .padding(.horizontal, 4)
                        .cornerRadius(8)
                    
                    Divider()
                    
                    HStack {
                        PriorityPickerView(selectedPriority: $viewModel.selectedPriority)
                        
                        Spacer()
                        
                        Button {
                            isPresentedDatePickerScreen = true
                        } label: {
                            Image(systemName: "paperplane.fill")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(viewModel.selectedPriority.color())
                        }
                    }
                    
                    Spacer().frame(height: 40)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 20)
            }
            .fullScreenCover(isPresented: $isPresentedDatePickerScreen) {
                AddTimeScreenView(isSaveButtonClicked: $viewModel.isSaveTaskButtonClicked, isShowTimePicker: $viewModel.isSelectedTime, focusDate: $viewModel.taskTillDate, selectedTime: $viewModel.taskTillTime)
            }
            .cornerRadius(16)
            .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    AddTaskView(viewModel: AddTaskViewModelImpl())
}
