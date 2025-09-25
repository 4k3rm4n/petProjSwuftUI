//
//  RoundedTaskView.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 25.09.2025.
//

import SwiftUI

protocol RoundedTaskViewModel: ObservableObject {
    var taskName: String { get }
    var taskPriority: TaskPriority { get }
    var taskStatus: TaskStatus { get set }
    var tillTime: String { get set }
    var tillDate: String { get set }
}

struct RoundedTaskView<ViewModel>: View where ViewModel: RoundedTaskViewModel {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            Color.blue
                .opacity(0.2)
            
            VStack {
                HStack {
                    Label("Task priority", systemImage: "flag")
                        .font(.system(size: 12))
                        .foregroundStyle(.white)
                        .labelStyle(TitleAndIconLabelStyle())

                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 11)
                .background(Color.red) // priority colors
                
                HStack {
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundStyle(.red) //task Status
                    
                    Text("Task name")
                        .font(.system(size: 16, weight: .medium))
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                
                Divider()
                    .padding(.horizontal, 16)
                
                HStack {
                    Label("08:30 PM", systemImage: "alarm") // Till Time
                        .font(.system(size: 12))
                        .foregroundStyle(.red) //
                    
                    Spacer()
                    
                    Text("Mon, 19 Jul 2022") // Till Date
                        .font(.system(size: 12))
                        .foregroundStyle(.gray)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                
                Spacer()
            }
        }
        .fixedSize(horizontal: false, vertical: true)
        .cornerRadius(8)
    }
}

#Preview {
    RoundedTaskView()
}
