//
//  AddTimeScreenView.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 30.09.2025.
//

import SwiftUI
import SwiftUICalendar

struct AddTimeScreenView: View {
    
    @Environment(\.dismiss) var dismiss
    let dismissParent: () -> Void
    @Binding var isSaveButtonClicked: Bool
    @Binding var isShowTimePicker: Bool
    @Binding var focusDate: YearMonthDay?
    @Binding var selectedTime: Date
    
    @State var saveButtonText: String = "Save without a deadline"
    
    var body: some View {
        VStack(spacing: 12) {
            VStack {
                HStack {
                    Button {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            isShowTimePicker.toggle()
                        }
                    } label: {
                        Image(systemName: "clock.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(focusDate == nil ? .gray : .teal)
                    }
                    .disabled(focusDate == nil)
                    
                    Spacer()
                }
                
                DatePicker("Оберіть час", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .frame(maxWidth: .infinity)
                    .frame(height: isShowTimePicker ? 200 : 0)
                    .background(Color.teal)
                    .cornerRadius(10)
            }
            .onChange(of: focusDate) { oldValue, newValue in
                if newValue == nil {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        isShowTimePicker = false
                        saveButtonText = "Save without a deadline"
                    }
                } else {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        saveButtonText = "Reschedule"
                    }
                }
            }
            
            Divider()
            
            CustomCalendarView(focusDate: $focusDate)
                .frame(height: 325)
            
            Spacer()
            
            SetDateTimeRoundedButton(buttonText: $saveButtonText) {
                isSaveButtonClicked = true
                dismiss()
                dismissParent()
            }
        }
        .padding(24)
    }
}

#Preview {
    AddTimeScreenView(dismissParent: {}, isSaveButtonClicked: .constant(false), isShowTimePicker: .constant(false), focusDate: .constant(YearMonthDay.current), selectedTime: .constant(Date()))
}
