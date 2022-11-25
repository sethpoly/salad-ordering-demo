//
//  ItemViewModel.swift
//  SaladFoodOrderingApp (iOS)
//
//  Created by Seth Polyniak on 11/10/22.
//

import Foundation

class ItemViewModel: ObservableObject {
    @Published var itemsInCart = [Item]()
    @Published private(set) var items: [Item] = Item.getDummyItems()
    
    func addItemToCart(item: Item) {
        itemsInCart.append(item)
    }
}
