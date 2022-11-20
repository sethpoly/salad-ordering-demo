//
//  SlideOutCart.swift
//  SaladFoodOrderingApp (iOS)
//
//  Created by Seth Polyniak on 11/20/22.
//

import SwiftUI

struct SlideOutCart: View {
    
    var body: some View {
        ZStack {
            Color.onPrimary.ignoresSafeArea()
            VStack(alignment: .center) {
                // MARK: Close button
                CloseButton(onClick: {})
                Text("Your Order")
                    .font(.headline)
                    .foregroundColor(.background)
                    .fontWeight(.bold)
                    
                // TODO: Cart items (max 3)
                // MARK: Total/Total price
                CartTotal(total: 42.6)
                // TODO: Checkmark
            }
        }
    }
}

struct CloseButton: View {
    let onClick: () -> Void
    var foregroundColor: Color = .onSecondary
    var backgroundColor: Color = .primaryVariant
    
    var body: some View {
        Button(action: onClick) {
            Image(systemName: "xmark")
                .padding()
                .foregroundColor(foregroundColor)
                .background(backgroundColor)
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 5)
        }
    }
}

private struct CartTotal: View {
    let total: Double
    
    var body: some View {
        VStack {
            Text("Total")
                .foregroundColor(.white.opacity(0.9))
            Text(total.currencyFormat)
                .font(.headline)
                .foregroundColor(.background)
                .fontWeight(.bold)
        }
    }
}

struct SlideOutCart_Previews: PreviewProvider {
    static var previews: some View {
        PreviewMe {
            SlideOutCart()
        }
    }
}
