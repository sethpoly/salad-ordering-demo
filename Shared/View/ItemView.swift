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
                    RoundArrowButton(isRightFacing: false) {
                        // TODO: Prev item
                    }
                    Spacer()
                    // Item name
                    Text("Item name")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    RoundArrowButton(isRightFacing: true) {
                        // TODO: Next item
                    }
                }
                
                // Review stars/count
                HStack {
                    Rating(
                        rating: .constant(5),
                        label: "110 reviews"
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

struct RoundArrowButton: View {
    let isRightFacing: Bool
    let onClick: () -> Void
    var foregroundColor = Color.onPrimary
    var backgroundColor = Color.primaryColor
    
    var body: some View {
        Button(action: onClick) {
            Image(systemName: isRightFacing ? "chevron.right" : "chevron.left")
                .padding()
                .foregroundColor(foregroundColor)
                .background(backgroundColor)
                .clipShape(Circle())
        }
    }
}

struct AddToCartButton: View {
    let onClick: () -> Void
    var backgroundColor = Color.secondaryColor
    var foregroundColor = Color.onSecondary
    
    var body: some View {
        Button(action: onClick) {
            Image(systemName: "bag")
            Text("Add to cart")
        }
        .padding()
        .background(backgroundColor)
        .foregroundColor(foregroundColor)
        .cornerRadius(ShapeManager.buttonShape)
    }
}

struct QuantityButton: View {
    var backgroundColor = Color.secondaryColor
    var foregroundColor = Color.onSecondary
    
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
        .foregroundColor(foregroundColor)
        .padding()
        .background(backgroundColor)
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
