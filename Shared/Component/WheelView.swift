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

struct WheelView: View {
    // Circle Radius
    @State var radius : Double = 150
    // Direction of swipe
    @State var direction = Direction.left
    // index of the number at the bottom of the circle
    @State var chosenIndex = 0
    // degree of circle and hue
    @Binding var degree : Double
//    @State var degree = 90.0
    let array : [Item]
    let circleSize : Double

    
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
                Circle().fill(EllipticalGradient(colors: [.orange,.yellow]))
                    .hueRotation(Angle(degrees: degree))

                ForEach(0 ..< array.count) { index in
                    let angle = Double(index) * anglePerCount
                    let xOffset = CGFloat(radius * cos(angle))
                    let yOffset = CGFloat(radius * sin(angle))
                    Text("\(array[index].name)")
                        .rotationEffect(Angle(degrees: -degree))
                        .offset(x: xOffset, y: yOffset )
                        .font(Font.system(chosenIndex == index ? .title : .body, design: .monospaced))
                }
            }
            .rotationEffect(Angle(degrees: degree))
            .gesture(drag)
            .onAppear() {
                radius = circleSize/2 - 30 // 30 is for padding
            }
            // MARK: WHEEL STACK - END
        }
        .frame(width: circleSize, height: circleSize)
    }
}

private struct WheelView_Stateful: View {
    @State var degree = 90.0
    
    var body: some View {
        WheelView(degree: $degree, array: Item.getDummyItems(), circleSize: 400)
    }
}

struct WheelView_Previews: PreviewProvider {
    static var previews: some View {
        WheelView_Stateful()
    }
}
