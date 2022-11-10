//
//  RoundArrowButton.swift
//  SaladFoodOrderingApp (iOS)
//
//  Created by Seth Polyniak on 11/10/22.
//

import SwiftUI

struct RoundArrowButton: View {
    let isRightFacing: Bool
    let onClick: () -> Void
    var foregroundColor = Color.onPrimary
    var backgroundColor = Color.primaryColor
    
    var body: some View {
        Button(action: onClick) {
            Image(systemName: isRightFacing ? "chevron.right" : "chevron.left")
                .padding()
                .foregroundColor(foregroundColor)
                .background(backgroundColor)
                .clipShape(Circle())
        }
    }
}

struct RoundArrowButton_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
        RoundArrowButton(
            isRightFacing: false) {
            
        }
        
        RoundArrowButton(
            isRightFacing: true) {
            
        }
        }
    }
}

