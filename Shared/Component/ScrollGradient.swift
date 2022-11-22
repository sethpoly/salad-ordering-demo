//
//  ScrollGradient.swift
//  SaladFoodOrderingApp (iOS)
//
//  Created by Seth Polyniak on 11/22/22.
//

import SwiftUI

struct ScrollGradient: ViewModifier {
    func body(content: Content) -> some View {
        content
            .mask(
                VStack(spacing: 0) {
                    // Top gradient
                    LinearGradient(gradient:
                       Gradient(
                           colors: [Color.black.opacity(0), Color.black]),
                                   startPoint: .top, endPoint: .bottom
                       )
                       .frame(height: 50)

                    // Middle
                    Rectangle().fill(Color.black)

                    // Bottom gradient
                    LinearGradient(gradient:
                       Gradient(
                           colors: [Color.black, Color.black.opacity(0)]),
                           startPoint: .top, endPoint: .bottom
                       )
                       .frame(height: 50)
                }
             )
    }
    
}

