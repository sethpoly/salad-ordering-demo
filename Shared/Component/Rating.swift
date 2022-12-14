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
    var onColor = Color.ratingYellow
    
    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                image(for: number)
                    .resizable()
                    .foregroundColor(number > rating ? offColor : onColor)
                    .frame(maxWidth: 12, maxHeight: 12)
            }
            if label.isEmpty == false {
                Text(label)
                    .foregroundColor(Color.secondaryVariant)
                    .font(.caption)
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
        Rating(rating: .constant(5), label: "110 reviews")
    }
}
