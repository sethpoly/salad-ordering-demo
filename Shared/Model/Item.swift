//
//  Item.swift
//  SaladFoodOrderingApp (iOS)
//
//  Created by Seth Polyniak on 11/20/22.
//

import Foundation

enum Nutrient: String {
    case calories
    case sugars
    case protein
}

struct Item: Equatable, Hashable {
    let id: Int
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
                    id: i,
                    name: "Item \(i)",
                    description:
                        "\(i) - Lorem ipsum dolor sit amet, consectetur adipiscing elit, " +
                        "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    price: Double(i) * 5.3,
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
