//
//  Dollar.swift
//  TipCalculator
//
//  Created by Xinyuan Wang on 11/7/18.
//  Copyright © 2018 Xinyuan Wang. All rights reserved.
//

import Foundation

protocol Currency: CustomStringConvertible {
    init(value: Float)
    var value: Float { get }
    var symbol: String { get }
}

extension Currency{
    var description: String {
        return symbol + String(format: "%.2f", value)
    }
}

struct Dollar: Currency {
    
    private(set) var value: Float
    
    init(value: Float) {
        self.value = value
    }
    
    var symbol: String {
        return "$"
    }
}
