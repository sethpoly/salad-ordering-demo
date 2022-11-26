//
//  ContentView.swift
//  Shared
//
//  Created by Seth Polyniak on 11/3/22.
//

import SwiftUI

struct ItemView: View {
    @StateObject var viewModel = ItemViewModel()
    @State var chosenIndex = 0
    @State var wheelDegree = 90.0
    @State private var showCart = false
    
    var body: some View {
        GeometryReader { metrics in
            ZStack {
                NavigationView {
                    ZStack{
                        Color.background.overlay {
                            Circle()
                                .foregroundColor(.primaryColor)
                                .frame(width: 600, height: 600)
                                .offset(x: 0, y: -450)
                        }
                        
                        WheelView(
                            chosenIndex: $chosenIndex,
                            degree: $wheelDegree,
                            array: viewModel.items,
                            circleSize: 500
                        ) { item in
                            Image(item.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        .offset(x: 0, y: -400)
                        .frame(height: metrics.size.height * 0.4)
                        
                        ItemDetailView(
                            item: viewModel.items[chosenIndex],
                            onItemNext: {
                                cycleItems(isNext: true)
                            },
                            onItemPrevious: {
                                cycleItems(isNext: false)
                            },
                            onAddToCart: {
                                viewModel.addItemToCart(item: viewModel.items[chosenIndex])
                            }
                        )
                        .frame(height: metrics.size.height * 0.7)
                    }
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
                            if !showCart {
                                OpenCartButton(
                                    currentItemCount: viewModel.itemsInCart.count) {
                                        toggleCartVisibility()
                                    }
                            }
                        }
                    }
                    .padding(PaddingManager.viewPadding)
                }
                
                if showCart {
                    SlideOutCart(
                        itemsInCart: $viewModel.itemsInCart,
                        width: 75,
                        onDismiss: toggleCartVisibility
                    )
                    .transition(.move(edge: .trailing))
                }
            }
        }
    }
    
    func cycleItems(isNext: Bool) {
        withAnimation(.spring()) {
            wheelDegree += isNext ? Double(360/viewModel.items.count) : -Double(360/viewModel.items.count)
            chosenIndex = viewModel.items.cycleArrayToIndex(currentIndex: chosenIndex, isNext: isNext)
        }
    }
    
    func toggleCartVisibility() {
        withAnimation {
            showCart.toggle()
        }
    }
}

private struct ItemDetailView: View {
    let item: Item
    let onItemNext: () -> Void
    let onItemPrevious: () -> Void
    let onAddToCart: () -> Void
    
    var body: some View {
        GeometryReader { metrics in
            VStack(spacing: 24) {
                Spacer()
                // Buttons/item name
                HStack {
                    // Prev item
                    RoundArrowButton(isRightFacing: false, onClick: onItemPrevious)
                    
                    Spacer()
                    // Item name
                    Text(item.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    Spacer()
                    // Next item
                    RoundArrowButton(isRightFacing: true, onClick: onItemNext)
                }
                
                VStack {
                    // Review stars/count
                    HStack {
                        Rating(
                            rating: .constant(item.rating),
                            label: "\(item.reviewCount) reviews"
                        )
                        Spacer()
                    }
                    
                    // Description
                    Text(item.description)
                        .font(.headline)
                        .minimumScaleFactor(0.1)
                        .foregroundColor(.secondaryVariant)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(4)
                }
                
                // Price/Ingredients
                HStack(spacing: 24) {
                    // Price
                    Text(item.price.currencyFormat)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    // Ingredients
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(Array(item.nutrientData.keys), id: \.self) { key in
                                IngredientCard(ingredientName: "\(item.nutrientData[key] ?? 0) \(key)")
                            }
                        }
                    }
                }
                HStack {
                    AddToCartButton(onClick: onAddToCart)
                        .frame(maxWidth: metrics.size.width * 0.65)
                    
                    QuantityButton()
                        .frame(maxWidth: metrics.size.width * 0.35)
                }
            }
        }
    }
}

private struct OpenCartButton: View {
    let currentItemCount: Int
    let onClick: () -> Void
    var buttonColor: Color = .onPrimary
    var dotColor: Color = .background
    var textColor: Color = .onBackground
    
    var body: some View {
        Button(action: onClick) {
            Image(systemName: "bag")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 32, height: 32)
                .foregroundColor(buttonColor)
                .overlay {
                    if currentItemCount != 0 {
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
        PreviewMe {
            ItemView()
        }
    }
}
