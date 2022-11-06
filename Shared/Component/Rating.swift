//
//  Rating.swift
//  SaladFoodOrderingApp (iOS)
//
//  Created by Seth Polyniak on 11/6/22.
//

import Foundation
import SwiftUI

struct Rating: View {
    @Binding var rating: Int
    
    var label = ""
    var maximumRating = 5
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor)
            }
            if label.isEmpty == false {
                Text(label)
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct Rating_Preview: PreviewProvider {
    static var previews: some View {
        Rating(rating: .constant(5))
    }
}
