//
//  Counter.swift
//  TapCounter
//
//  Created by Xinyuan Wang on 11/7/18.
//  Copyright © 2018 Xinyuan Wang. All rights reserved.
//

import Foundation

struct Counter: CustomStringConvertible {
    //MARK: Public APIs
    var value: Int = 0
    
    //MARK: init method
    init(value v: Int) {
        value = v
    }
    
    var description: String {
        return String(value)
    }
}
