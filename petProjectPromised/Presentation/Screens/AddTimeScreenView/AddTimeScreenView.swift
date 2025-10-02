//
//  AddTimeScreenView.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 30.09.2025.
//

import SwiftUI
import SwiftUICalendar

struct AddTimeScreenView: View {
    
    @Binding var focusDate: YearMonthDay?
    @Binding var selectedTime: Date
    
    var body: some View {
        VStack(spacing: 24) {
            DatePicker("Оберіть час", selection: $selectedTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
                .labelsHidden()
                .frame(maxWidth: .infinity)
                .background(Color.teal)
                .cornerRadius(10)
            
            Divider()
            
            CustomCalendarView(focusDate: $focusDate)
                .frame(height: 325)
            
            Spacer()
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    AddTimeScreenView(focusDate: .constant(YearMonthDay.current), selectedTime: .constant(Date()))
}
