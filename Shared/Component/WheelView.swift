//
//  WheelView.swift
//  SaladFoodOrderingApp (iOS)
//
//  Created by Seth Polyniak on 11/15/22.
// https://betterprogramming.pub/wheel-picker-view-in-swiftui-6de7077b4791

import SwiftUI

enum Direction {
    case left
    case right
}

struct WheelView<Content: View>: View {
    @State var radius : Double = 150
    @State var direction = Direction.left
    @Binding var chosenIndex: Int
    @Binding var degree : Double
    let array : [Item]
    let circleSize : Double
    let content: (Item) -> Content
    
    func moveWheel() {
        withAnimation(.spring()) {
            if direction == .left {
                degree += Double(360/array.count)
                if chosenIndex == 0 {
                    chosenIndex = array.count-1
                } else {
                    chosenIndex -= 1
                }
            } else {
                degree -= Double(360/array.count)
                if chosenIndex == array.count-1 {
                    chosenIndex = 0
                } else {
                    chosenIndex += 1
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
            let anglePerCount = Double.pi * 2.0 / Double(array.count)
            let drag = DragGesture()
                .onEnded { value in
                    if value.startLocation.x > value.location.x + 10 {
                        direction = .left
                    } else if value.startLocation.x < value.location.x - 10 {
                        direction = .right
                    }
                    moveWheel()
                }
            // MARK: WHEEL STACK - BEGINNING
            ZStack {
                ForEach(0..<array.count, id: \.self) { index in
                    let angle = Double(index) * anglePerCount
                    let xOffset = CGFloat(radius * cos(angle))
                    let yOffset = CGFloat(radius * sin(angle))
                    content(array[index])
                        .rotationEffect(Angle(degrees: -degree))
                        .offset(x: xOffset, y: yOffset)
                        .opacity(index == chosenIndex ? 1.0 : 0.0)
                }
            }
            .rotationEffect(Angle(degrees: degree))
            .gesture(drag)
            .onAppear() {
                radius = circleSize/2 - 30 // 30 is for padding
            }
            // MARK: WHEEL STACK - END
        }
    }
}

private struct WheelView_Stateful: View {
    @State var degree = 90.0
    @State var chosenIndex = 0
    
    var body: some View {
        WheelView(chosenIndex: $chosenIndex, degree: $degree,array: Item.getDummyItems(), circleSize: 400) { item in
            VStack {
            Text(item.name)
                Text(item.description)
            }
        }
    }
}

struct WheelView_Previews: PreviewProvider {
    static var previews: some View {
        WheelView_Stateful()
    }
}
