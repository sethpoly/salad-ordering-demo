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
        return DummyItem.allCases.enumerated().map({
            Item(
                id: $0,
                name: $1.name,
                description: $1.description,
                price: (Double($0) + 2) * 5.3,
                rating: Int.random(in: 4...5),
                reviewCount: Int.random(in: 1...200),
                imageName: $1.imageName,
                nutrientData: [
                    .calories: 120,
                    .sugars: 30,
                    .protein: 23
                ])
        })
    }
    
    static func fromDummyItem(dummyItem: DummyItem) -> Item {
        return Item(
            id: dummyItem.rawValue,
            name: dummyItem.name,
            description: dummyItem.description,
            price: (Double(dummyItem.rawValue) + 2) * 5.3,
            rating: Int.random(in: 4...5),
            reviewCount: Int.random(in: 1...200),
            imageName: dummyItem.imageName,
            nutrientData: [
                .calories: 120,
                .sugars: 30,
                .protein: 23
            ])
    }
}

enum DummyItem: Int, CaseIterable {
    case chickenTinga = 0
    case chineseChicken = 1
    case harvest = 2
    case mediterranean = 3
    
    var name: String {
        switch self {
        case .chickenTinga: return "Chicken Tinga Bowl"
        case .chineseChicken: return "Chinese Chicken Bowl"
        case .harvest: return "Harvest Bowl"
        case .mediterranean: return "Mediterranean Bowl"
        }
    }
    
    var description: String {
        switch self {
        case .chickenTinga: return "Warm grains or cauliflower rice drizzled with Mexican Goddess and topped with braised chicken tinga, avocado, black beans, tortilla chips, scallions, cotija cheese, marinated kale"
        case .chineseChicken: return "Warm grains or cauliflower rice drizzled with Sesame Ginger Dressing and topped with warm roasted chicken, rainbow carrots, broccoli, pickled red onion, crispy wontons, cabbage & cilantro blend"
        case .harvest: return "Warm grains or cauliflower rice drizzled with Creamy Lemon Herb Dressing and topped with warm roasted chicken, roasted Brussels sprouts & sweet potatoes, marinated kale, toasted pumpkin seeds"
        case .mediterranean: return "Warm grains or cauliflower rice drizzled with Lemon Tahini Dressing and topped with warm roasted chicken, cucumber & tomato salad, local feta, Mama Lil's spicy peppers, cabbage & cilantro blend, crispy chickpeas"
        }
    }
    
    var imageName: String {
        switch self {
        case .chickenTinga: return "chickenTinga"
        case .chineseChicken: return "chineseChicken"
        case .harvest: return "harvest"
        case .mediterranean: return "mediterranean"
        }
    }
    
}
