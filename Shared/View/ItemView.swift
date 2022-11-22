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
        NavigationView {
            ZStack {
            ZStack(alignment: .top) {
                Color.background.overlay {
                    Circle()
                        .foregroundColor(.primaryColor)
                        .frame(width: 600, height: 600)
                        .offset(x: 0, y: -450)
                }
                
                VStack(spacing: 0) {
                    WheelView(
                        chosenIndex: $chosenIndex,
                        degree: $wheelDegree,
                        array: viewModel.items,
                        circleSize: 500
                    ) { item in
                        // TODO: Item image
                        ZStack {}
                            .frame(width: 150, height: 150)
                            .background(Color.red)
                    }
                    .offset(x: 0, y: -250)
                        ItemDetailView(
                            item: viewModel.items[chosenIndex],
                            onItemNext: {
                                cycleItems(isNext: true)
                            },
                            onItemPrevious: {
                                cycleItems(isNext: false)
                            }
                        )
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
                    if !showCart {
                        OpenCartButton(currentItemCount: 1) {
                            toggleCartVisibility()
                        }
                    }
                }
            }
                if showCart {
                    SlideOutCart(
                        itemsInCart: .constant([]),
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
    
    var body: some View {
        GeometryReader { metrics in
            VStack {
                // Buttons/item name
                HStack {
                    // Prev item
                    RoundArrowButton(isRightFacing: false, onClick: onItemPrevious)
            
                    Spacer()
                    // Item name
                    Text(item.name)
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    // Next item
                    RoundArrowButton(isRightFacing: true, onClick: onItemNext)
                }
                
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
                    .font(.subheadline)
                    .foregroundColor(.secondaryVariant)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
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
                
                Spacer()
                
                HStack {
                    AddToCartButton(onClick: {})
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

struct WrappingItems: View {
    var tags: [AnyView]

    @State private var totalHeight
          = CGFloat.zero       // << variant for ScrollView/List
    //    = CGFloat.infinity   // << variant for VStack

    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)// << variant for ScrollView/List
        //.frame(maxHeight: totalHeight) // << variant for VStack
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(self.tags.indices, id: \.self) { i in
                self.item(for: tags[i])
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if i == self.tags.count - 1 {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if i == self.tags.count - 1 {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }.background(viewHeightReader($totalHeight))
    }

    private func item(for text: AnyView) -> some View {
        text
            .padding(.all, 5)
            .font(.body)
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(5)
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewMe {
            ItemView()
        }
    }
}
