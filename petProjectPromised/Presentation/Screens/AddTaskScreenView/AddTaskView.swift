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
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("Task Name", text: $viewModel.taskNameText)
                .background(Color(.white))
                .cornerRadius(8)
            
            TextField("Description", text: $viewModel.taskDescriptionText)
                .background(Color(.white))
                .cornerRadius(8)
            
            Divider()
            
            HStack {
                PriorityPickerView(selectedPriority: $viewModel.selectedPriority)
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "paperplane.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(viewModel.selectedPriority.color())
                }
            }
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    AddTaskView(viewModel: AddTaskViewModelImpl())
}
