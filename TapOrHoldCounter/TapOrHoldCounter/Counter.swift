//
//  Counter.swift
//  TapOrHoldCounter
//
//  Created by Xinyuan Wang on 11/7/18.
//  Copyright © 2018 Xinyuan Wang. All rights reserved.
//

import Foundation

struct Counter: CustomStringConvertible {
    var value: Int
    init(value v: Int) {
        value = v
    }
    
    var description: String {
        return "\(value)"
    }
}
