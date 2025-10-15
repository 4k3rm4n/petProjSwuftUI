//
//  CustomCalendarView.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 02.10.2025.
//

import SwiftUI
import SwiftUICalendar

struct CustomCalendarView: View {
    
    @ObservedObject var controller: CalendarController = CalendarController()
    @Binding var focusDate: YearMonthDay?
    
    var body: some View {
        GeometryReader { reader in
            VStack {
                HStack(alignment: .center, spacing: 0) {
                    Button(action: {
                        controller.scrollTo(controller.yearMonth.addMonth(value: -1), isAnimate: true)
                    }, label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.black)
                    })
                    .padding(8)
                    
                    Spacer()
                    
                    Text("\(controller.yearMonth.monthShortString), \(String(controller.yearMonth.year))")
                        .font(.title)
                        .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                    
                    Spacer()
                    
                    Button(action: {
                        controller.scrollTo(controller.yearMonth.addMonth(value: 1), isAnimate: true)
                    }, label: {
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.black)
                    })
                    .padding(8)
                }
                
                CalendarView(controller, header: { week in
                    GeometryReader { geometry in
                        
                        Text(week.shortString)
                            .font(.subheadline)
                            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                    }
                }, component: { date in
                    GeometryReader { geometry in
                        
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                            .foregroundColor(focusDate == date ? .teal : .clear)
                        
                        Text("\(date.day)")
                            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                            .opacity(date.isFocusYearMonth == true ? 1 : 0.4)
                            .font(.system(size: 12, weight: .bold, design: .default))
                            .foregroundColor(focusDate == date ? .white : .black)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.25)) {
                                    focusDate = (date != focusDate ? date : nil)
                                }
                            }
                    }
                })
            }
        }
    }
}

#Preview {
    CustomCalendarView(focusDate: .constant(YearMonthDay.current))
}
