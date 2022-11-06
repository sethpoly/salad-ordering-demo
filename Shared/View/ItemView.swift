//
//  ContentView.swift
//  Shared
//
//  Created by Seth Polyniak on 11/3/22.
//

import SwiftUI

struct ItemView: View {
    var body: some View {
        ZStack {
            Color.background
            VStack {
                // TODO: Nav bar
                // TODO: Salad image
                ZStack {}
                    .frame(width: 200, height: 200)
                    .background(Color.red)
                // TODO: Buttons/item name
                HStack {
                    ArrowButton(isRightFacing: false) {
                        // TODO: Prev item
                    }
                    Spacer()
                    Text("Item name")
                    Spacer()
                    ArrowButton(isRightFacing: true) {
                        // TODO: Next item
                    }
                }
                
                // Review stars/count
                HStack {
                    Rating(
                        rating: .constant(5),
                        label: "wow"
                    )
                    Spacer()
                }
                
                // Description
                Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
                )
                
                // Price/Ingredients
                HStack(spacing: 24) {
                    // Price
                    Text("Price")
                    // Ingredients
                    IngredientCard(ingredientName: "foo")
                    IngredientCard(ingredientName: "bar")
                    Spacer()
                }
                
                HStack {
                    // Add to cart
                    AddToCartButton(onClick: {})

                    // Quantity btn(s)
                    QuantityButton()
                }
            }
        }
        .padding(PaddingManager.viewPadding)
    }
}

struct ArrowButton: View {
    let isRightFacing: Bool
    let onClick: () -> Void
    
    var body: some View {
        Button(action: onClick) {
            Text("clicker")
        }
    }
}

struct AddToCartButton: View {
    let onClick: () -> Void
    
    var body: some View {
        Button(action: onClick) {
            Image(systemName: "bag")
            Text("Add to cart")
        }
        .padding()
        .background(Color.secondaryColor)
        .foregroundColor(.onSecondary)
        .cornerRadius(ShapeManager.buttonShape)
    }
}

struct QuantityButton: View {
    
    var body: some View {
        HStack {
            Button(action: {}) {
                Text("-")
            }
            Spacer()
            Text("1")
            Spacer()
            Button(action: {}) {
                Text("+")
            }
        }
        .foregroundColor(Color.onSecondary)
        .padding()
        .background(Color.secondaryColor)
        .cornerRadius(ShapeManager.buttonShape)
    }
}

private struct IngredientCard: View {
    let ingredientName: String
    var body: some View {
        Text(ingredientName)
            .padding(8)
            .padding(.horizontal, 10)
            .foregroundColor(Color.onPrimary)
            .background(Color.primaryColor)
            .cornerRadius(ShapeManager.cardShape)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView()
    }
}
