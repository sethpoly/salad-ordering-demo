//
//  ItemViewModel.swift
//  SaladFoodOrderingApp (iOS)
//
//  Created by Seth Polyniak on 11/10/22.
//

import Foundation

class ItemViewModel: ObservableObject {
    @Published private(set) var items: [Item] = Item.getDummyItems()
}
