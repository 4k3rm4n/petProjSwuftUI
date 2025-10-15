//
//  RoundedTaskView.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 25.09.2025.
//

import SwiftUI

protocol RoundedTaskViewModel: ObservableObject, Identifiable {
    var id: UUID { get }
    var taskName: String { get }
    var taskPriority: TaskPriority { get }
    var taskStatus: TaskStatus { get set }
    var tillTime: String? { get set }
    var tillDate: String? { get set }
}

struct RoundedTaskView<ViewModel>: View where ViewModel: RoundedTaskViewModel {
    @ObservedObject var viewModel: ViewModel
    
    @State private var taskOffsetX: CGFloat = .zero
    
    var body: some View {
        ZStack {
            Color.white
            
            VStack {
                HStack {
                    Label(viewModel.taskPriority.title(), systemImage: "flag")
                        .font(.system(size: 12))
                        .foregroundStyle(.white)
                        .labelStyle(TitleAndIconLabelStyle())

                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 11)
                .background(viewModel.taskPriority.color()) // priority colors
                
                HStack {
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundStyle(viewModel.taskPriority.color()) //task Status
                    
                    Text(viewModel.taskName)
                        .font(.system(size: 16, weight: .medium))
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                
                Divider()
                    .padding(.horizontal, 16)
                
                HStack {
                    if let time = viewModel.tillTime {
                        Label(time, systemImage: "alarm") // Till Time
                            .font(.system(size: 12))
                            .foregroundStyle(.red)
                    }
                    
                    Spacer()
                    
                    if let date = viewModel.tillDate {
                        Text(date) // Till Date
                            .font(.system(size: 12))
                            .foregroundStyle(.gray)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                
                Spacer()
            }
        }
        .fixedSize(horizontal: false, vertical: true)
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 0)
        .padding(.horizontal, 10)
        .offset(x: taskOffsetX)
        .simultaneousGesture(
            DragGesture()
                .onChanged { gesture in
                    if gesture.translation.width < 0 {
                        taskOffsetX = gesture.translation.width
                    }
                }
                .onEnded { gesture in
                    if gesture.translation.width < -45 {
                        taskOffsetX = -90
                    } else {
                        taskOffsetX = 0
                    }
                }
        )
        .animation(.easeInOut, value: taskOffsetX)
    }
}

#Preview {
    RoundedTaskView(viewModel: RoundedTaskViewModelImpl.mock)
}
