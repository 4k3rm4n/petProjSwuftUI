//
//  AddTimeScreenView.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 30.09.2025.
//

import SwiftUI
import SwiftUICalendar

protocol AddTimeScreenViewModel: ObservableObject {
    var isShowTimePicker: Bool { get set }
    var taskSelectedTime: Date { get set }
    var taskTillDate: YearMonthDay? { get set }
    
    func saveTask()
}

struct AddTimeScreenView<ViewModel>: View where ViewModel: AddTimeScreenViewModel {
    
    @ObservedObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    
    @State var saveButtonText: String = "Save without a deadline"
    
    var body: some View {
        VStack(spacing: 12) {
            VStack {
                HStack {
                    Button {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            viewModel.isShowTimePicker.toggle()
                        }
                    } label: {
                        Image(systemName: "clock.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(viewModel.taskTillDate == nil ? .gray : .teal)
                    }
                    .disabled(viewModel.taskTillDate == nil)
                    
                    Spacer()
                }
                
                DatePicker("Оберіть час", selection: $viewModel.taskSelectedTime , displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .frame(maxWidth: .infinity)
                    .frame(height: viewModel.isShowTimePicker ? 200 : 0)
                    .background(Color.teal)
                    .cornerRadius(10)
            }
            .onChange(of: viewModel.taskTillDate) { oldValue, newValue in
                if newValue == nil {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        viewModel.isShowTimePicker = false
                        saveButtonText = "Save without a deadline"
                    }
                } else {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        saveButtonText = "Reschedule"
                    }
                }
            }
            
            Divider()
            
            CustomCalendarView(focusDate: $viewModel.taskTillDate)
                .frame(height: 325)
            
            Spacer()
            
            SetDateTimeRoundedButton(buttonText: $saveButtonText) {
                viewModel.saveTask()
                dismiss()
            }
        }
        .padding(24)
    }
}

#Preview {
    AddTimeScreenView(viewModel: AddTimeScreenViewModelImpl(from: Task()))
}
