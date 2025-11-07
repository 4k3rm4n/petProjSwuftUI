//
//  AddTaskView.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 29.09.2025.
//

// MARK: TO DO fix animations in addTimeView ----------------------- ????
// MARK: TO DO discover addTaskView viewModel deinialized ---------- ????

// MARK: working commit 16.10.2025

import SwiftUI
import SwiftUICalendar

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var showAddTaskSheet: Bool
    @Binding var showAddDateTimeScreen: Bool
    @Binding var newTask: TaskDTO
    
    var body: some View {
            ZStack {
                Color.white
                
                VStack(spacing: 16) {
                    TextField("Task Name", text: $newTask.name)
                        .autocorrectionDisabled()
                        .background(Color(.white))
                        .padding(.horizontal, 4)
                        .cornerRadius(8)
                    
                    TextField("Description", text: $newTask.taskDescription, axis: .vertical)
                        .autocorrectionDisabled()
                        .background(Color(.white))
                        .padding(.horizontal, 4)
                        .cornerRadius(8)
                    
                    Divider()
                    
                    HStack {
                        PriorityPickerView(selectedPriority: $newTask.priority)
                        
                        Spacer()
                        
                        Button {
                            showAddTaskSheet = false
                            showAddDateTimeScreen = true
                        } label: {
                            Image(systemName: "paperplane.fill")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(newTask.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? .gray : newTask.priority.color())
                        }
                        .disabled(newTask.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
            }
            .cornerRadius(16)
            .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    AddTaskView(showAddTaskSheet: .constant(true), showAddDateTimeScreen: .constant(false), newTask: .constant(TaskDTO()))
}
