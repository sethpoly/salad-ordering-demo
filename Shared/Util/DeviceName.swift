//
//  DeviceName.swift
//  SaladFoodOrderingApp (iOS)
//
//  Created by Seth Polyniak on 11/10/22.
//

import Foundation

import Foundation

enum DeviceName: String, CaseIterable {
    case iPhone7 = "iPhone 7"
    case iPhoneX = "iPhone X"
    case iPhoneXs = "iPhone Xs"
    case iPhoneXsMax = "iPhone Xs Max"
    case iPhoneSE = "iPhone SE (3rd generation)"

    static var all: [String] {
        return DeviceName.allCases.map { $0.rawValue }
    }
}
