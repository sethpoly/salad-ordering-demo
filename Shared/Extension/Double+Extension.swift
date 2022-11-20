//
//  Double+Extension.swift
//  SaladFoodOrderingApp (iOS)
//
//  Created by Seth Polyniak on 11/20/22.
//

import Foundation

extension Double {
    var currencyFormat: String {
        return String(format: "$%.02f", self)
    }
}
