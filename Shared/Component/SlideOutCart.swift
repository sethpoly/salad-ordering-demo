//
//  SlideOutCart.swift
//  SaladFoodOrderingApp (iOS)
//
//  Created by Seth Polyniak on 11/20/22.
//

import SwiftUI

struct SlideOutCart: View {
    @Binding var itemsInCart: [Item]
    let width: CGFloat
    let onDismiss: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
                .onTapGesture {
                    onDismiss()
                }
        ZStack {
            Color.onPrimary.ignoresSafeArea()
            VStack(alignment: .center) {
                // MARK: Close button
                ImageCircleButton (onClick: onDismiss, imageSystemName: "xmark")
                Text("Your\nOrder")
                    .font(.headline)
                    .foregroundColor(.background)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    
                // TODO: Cart items (max 3)
                ScrollView {
                    ZStack(){}.frame(height: 2)
                    ForEach(itemsInCart.indices, id: \.self) { i in
                        CartItem(item: itemsInCart[i], onDelete: {
                            withAnimation(.linear) {
                                print(self.itemsInCart.count) // SwiftUI bug
                                self.itemsInCart.remove(at: i)
                            }
                        })
                        .frame(width: 72, height: 72)
                    }
                }
                .modifier(ScrollGradient())
                
                // MARK: Total/Total price
                CartTotal(total: 42.6)
                
                // MARK: Checkmark
                ImageCircleButton(
                    onClick: {},
                    imageSystemName: "checkmark",
                    foregroundColor: .primaryVariant,
                    backgroundColor: .background
                )
            }
        }
        .frame(width: self.width)
        .offset(x: 0, y: 0)
        .zIndex(5.0)
        }
    }
}

private struct CartItem: View {
    let item: Item
    let onDelete: () -> Void
    
    var body: some View {
        ZStack {
            // TODO: Item Image
            Circle().foregroundColor(.red)
                .frame(width: 72)
            Text(item.name)
            
            ZStack {
                Circle().foregroundColor(.darkPrimaryVariant)
                Image(systemName: "xmark")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 12)
                    .foregroundColor(.background)
            }
            .frame(maxWidth: 24)
            .offset(x: 0, y: -30)
            .modifier(Tappable(onTap: onDelete))
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

private struct SlideOutChart_Stateful: View {
    @State var itemsInCart = Item.getDummyItems()
    
    var body: some View {
        SlideOutCart(itemsInCart: $itemsInCart, width: 75, onDismiss: {})
    }
}

struct SlideOutCart_Previews: PreviewProvider {
    static var previews: some View {
        PreviewMe {
            VStack {
                SlideOutChart_Stateful()
            }
        }
    }
}
