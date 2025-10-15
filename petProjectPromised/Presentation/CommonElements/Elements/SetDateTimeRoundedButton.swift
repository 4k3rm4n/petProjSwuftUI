//
//  SetDateTimeRoundedButton.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 10.10.2025.
//

import SwiftUI

struct SetDateTimeRoundedButton: View {
    @Binding var buttonText: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "clock.arrow.circlepath")
                    .foregroundStyle(.white)
                
                Text(buttonText)
                    .font(.system(size: 20))
                    .foregroundStyle(.white)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.teal)
            .clipShape(Capsule())
        }
    }
}

#Preview {
    SetDateTimeRoundedButton(buttonText: .constant("Save without a deadline"), action: {})
}
