//
//  SetDateTimeRoundedButton.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 10.10.2025.
//

import SwiftUI

struct SetDateTimeRoundedButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "clock.arrow.circlepath")
                    .foregroundStyle(.white)
                
                Text("Reschedule")
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
    SetDateTimeRoundedButton(action: {})
}
