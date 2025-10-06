//
//  AddTaskView.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 29.09.2025.
//

import SwiftUI

protocol AddTaskViewModel: ObservableObject {
    var taskNameText: String { get set }
    var taskDescriptionText: String { get set }
    var selectedPriority: TaskPriority { get set }
}

struct AddTaskView<ViewModel>: View where ViewModel: AddTaskViewModel{
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
            ZStack {
                Color.white
                
                VStack(spacing: 16) {
                    TextField("Task Name", text: $viewModel.taskNameText)
                        .background(Color(.white))
                        .padding(.horizontal, 4)
                        .cornerRadius(8)
                    
                    TextField("Description", text: $viewModel.taskDescriptionText)
                        .background(Color(.white))
                        .padding(.horizontal, 4)
                        .cornerRadius(8)
                    
                    Divider()
                    
                    HStack {
                        PriorityPickerView(selectedPriority: $viewModel.selectedPriority)
                        
                        Spacer()
                        
                        Button {
                            
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
            .cornerRadius(16)
            .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    AddTaskView(viewModel: AddTaskViewModelImpl())
}
