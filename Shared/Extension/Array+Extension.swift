//
//  Array+Extension.swift
//  SaladFoodOrderingApp (iOS)
//
//  Created by Seth Polyniak on 11/20/22.
//

import Foundation

extension Array {
    func cycleArrayToIndex(currentIndex: Int, isNext: Bool) -> Int {
        var currentIndex = currentIndex
        if isNext {
            if currentIndex == 0 {
                currentIndex = self.count - 1
            } else {
                currentIndex -= 1
            }
        } else {
            if currentIndex == self.count - 1 {
                currentIndex = 0
            } else {
                currentIndex += 1
            }
        }
        return currentIndex
    }
}
