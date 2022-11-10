//
//  ContentView.swift
//  Shared
//
//  Created by Seth Polyniak on 11/3/22.
//

import SwiftUI

struct ItemView: View {
    var body: some View {
        GeometryReader { metrics in
            NavigationView {
                ZStack {
                    Color.background
                    VStack {
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
                        .font(.subheadline)
                        .foregroundColor(.secondaryVariant)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // Price/Ingredients
                        HStack(spacing: 24) {
                            // Price
                            Text("$7.89")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            // Ingredients
                            HStack {
                                IngredientCard(ingredientName: "foo")
                                IngredientCard(ingredientName: "bar")
                                IngredientCard(ingredientName: "buzz")
                            }
                            Spacer()
                        }
                        
                        HStack {
                            AddToCartButton(onClick: {})
                                .frame(maxWidth: metrics.size.width * 0.6)

                            QuantityButton()
                                .frame(maxWidth: metrics.size.width * 0.3)
                        }
                    }
                }
                .padding(PaddingManager.viewPadding)
                .toolbar {
                    // Hamburger menu
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                        } label: {
                            Image(systemName: "line.3.horizontal")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 32, height: 32)
                                .foregroundColor(.onPrimary)
                        }
                    }
                    
                    // Open cart button
                    ToolbarItem(placement: .navigationBarTrailing) {
                        OpenCartButton(currentItemCount: 1) {
                            // TODO: Open cart
                        }
                    }
                }
            }
        }
    }
}

private struct OpenCartButton: View {
    let currentItemCount: Int
    let onClick: () -> Void
    var buttonColor: Color = .onPrimary
    var dotColor: Color = .ratingYellow
    var textColor: Color = .onBackground
    
    var body: some View {
        Button(action: onClick) {
            Image(systemName: "bag")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 32, height: 32)
                .foregroundColor(buttonColor)
                .overlay {
                    ZStack {
                        Circle()
                        Text(String(currentItemCount))
                            .font(.system(size: 12))
                            .foregroundColor(textColor)
                    }
                    .foregroundColor(dotColor)
                    .frame(maxWidth: 18, maxHeight: 18)
                    .offset(x: -14, y: -9)
                }
        }
    }
}


private struct IngredientCard: View {
    let ingredientName: String
    
    var body: some View {
        Text(ingredientName)
            .font(.footnote)
            .padding(5)
            .padding(.horizontal, 16)
            .foregroundColor(Color.black.opacity(0.8))
            .background(Color.primaryColor)
            .cornerRadius(ShapeManager.cardShape)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView()
    }
}
