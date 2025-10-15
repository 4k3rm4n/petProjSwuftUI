//
//  AddTaskView.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 29.09.2025.
//

// MARK: TO DO RoundedTaskView remove constants -------------------- -
// MARK: TO DO VALIDATE() METHOD IN VIEWMODEL ---------------------- -
// MARK: TO DO fix when time was not choosen ----------------------- +
// MARK: TO DO fix animations in addTimeView ----------------------- -
// MARK: TO DO discover addTaskView viewModel deinialized ----------
// MARK: TO DO allow to do few rows in text fields in addTaskView -- +

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

struct AddTaskView<ViewModel>: View where ViewModel: AddTaskViewModel {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ViewModel
    @State var isPresentedDatePickerScreen: Bool = false
    @State private var textHeight: CGFloat = 30
    
    var body: some View {
            ZStack {
                Color.white
                
                VStack(spacing: 16) {
                    TextField("Task Name", text: $viewModel.taskNameText)
                        .autocorrectionDisabled()
                        .background(Color(.white))
                        .padding(.horizontal, 4)
                        .cornerRadius(8)
                    
                    TextField("Description", text: $viewModel.taskDescriptionText, axis: .vertical)
                        .autocorrectionDisabled()
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
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
            }
            .fullScreenCover(isPresented: $isPresentedDatePickerScreen) {
                AddTimeScreenView(dismissParent: { dismiss() }, isSaveButtonClicked: $viewModel.isSaveTaskButtonClicked, isShowTimePicker: $viewModel.isSelectedTime, focusDate: $viewModel.taskTillDate, selectedTime: $viewModel.taskTillTime)
            }
            .cornerRadius(16)
            .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    AddTaskView(viewModel: AddTaskViewModelImpl())
}
