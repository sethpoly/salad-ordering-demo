//
//  ImageCircleButton.swift
//  SaladFoodOrderingApp (iOS)
//
//  Created by Seth Polyniak on 11/20/22.
//

import SwiftUI

struct ImageCircleButton: View {
    let onClick: () -> Void
    let imageSystemName: String
    var foregroundColor: Color = .onSecondary
    var backgroundColor: Color = .primaryVariant
    
    var body: some View {
        Button(action: onClick) {
            Image(systemName: imageSystemName)
                .padding()
                .foregroundColor(foregroundColor)
                .background(backgroundColor)
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 5)
        }
    }
}
