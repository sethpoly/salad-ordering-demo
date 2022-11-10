//
//  PreviewMe.swift
//  SaladFoodOrderingApp (iOS)
//
//  Created by Seth Polyniak on 11/10/22.
//

import SwiftUI

/// Preview wrapper to show all device sizes at once
struct PreviewMe<Content: View>: View {
    let content: () -> Content
    
    var body: some View {
        ForEach(DeviceName.all, id: \.self) { name in
            ZStack {
                Color.background.ignoresSafeArea()
                content()
            }
            .previewDevice(PreviewDevice(rawValue: name))
            .previewDisplayName(name)
        }
    }
}
