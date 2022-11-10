//
//  QuantityButton.swift
//  SaladFoodOrderingApp (iOS)
//
//  Created by Seth Polyniak on 11/10/22.
//

import SwiftUI

struct QuantityButton: View {
    var backgroundColor = Color.secondaryColor
    var foregroundColor = Color.onSecondary
    
    var body: some View {
        HStack {
            Button(action: {}) {
                Text("-")
                    .font(.title2)
            }
            Spacer()
            Text("1")
                .font(.title2)
            Spacer()
            Button(action: {}) {
                Text("+")
                    .font(.title2)
            }
        }
        .foregroundColor(foregroundColor)
        .padding(12)
        .background(backgroundColor)
        .cornerRadius(ShapeManager.buttonShape)
    }
}

struct QuantityButton_Previews: PreviewProvider {
    static var previews: some View {
        QuantityButton()
    }
}
