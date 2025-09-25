//
//  ContentView.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 25.09.2025.
//

import SwiftUI

protocol HomeScreenViewModel: ObservableObject {
    
}

struct HomeScreenView: View {
    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()
            
            ScrollView {
                
            }
        }
    }
}

#Preview {
    HomeScreenView()
}
