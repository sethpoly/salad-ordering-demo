//
//  AddToCartButton.swift
//  SaladFoodOrderingApp (iOS)
//
//  Created by Seth Polyniak on 11/10/22.
//

import SwiftUI

struct AddToCartButton: View {
    let onClick: () -> Void
    var backgroundColor = Color.secondaryColor
    var foregroundColor = Color.onSecondary
    
    var body: some View {
        Button(action: onClick) {
            Image(systemName: "bag")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
            Text("Add to cart")
                .font(.title2)
                .frame(maxWidth: .infinity)
        }
        .padding(12)
        .background(backgroundColor)
        .foregroundColor(foregroundColor)
        .cornerRadius(ShapeManager.buttonShape)
    }
}

struct AddToCartButton_Previews: PreviewProvider {
    static var previews: some View {
        AddToCartButton(onClick: {})
    }
}
