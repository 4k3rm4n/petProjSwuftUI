//
//  EmptyTaskView.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 26.09.2025.
//

import SwiftUI

struct EmptyTaskView: View {
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 16) {
                Image(systemName: "tray")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80)
                    .foregroundStyle(.blue)
                
                Text("You have no tasks, Hooray!")
                    .font(.system(size: 17))
                    .foregroundStyle(.blue)
            }
        }
    }
}

#Preview {
    EmptyTaskView()
}
