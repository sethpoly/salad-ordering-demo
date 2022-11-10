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

struct Item {
    let name: String
    let description: String
    let price: Double
    let rating: Int
    let reviewCount: Int
    let imageName: String
    let nutrientData: [Nutrient: Int]
    
    static func getDummyItems() -> [Item] {
        var items: [Item] = []
        for i in 0...3 {
            items.append(
                Item(
                    name: "Item \(i)",
                    description: "description \(i)",
                    price: Double(i) * 5.0,
                    rating: Int.random(in: 1...5),
                    reviewCount: Int.random(in: 1...200),
                    imageName: "",
                    nutrientData: [
                        .calories: 120,
                        .sugars: 30,
                        .protein: 23
                    ]
                )
            )
        }
        return items
    }
}

enum Nutrient: String {
    case calories
    case sugars
    case protein
}

