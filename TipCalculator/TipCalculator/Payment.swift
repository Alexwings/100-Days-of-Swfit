//
//  Payment.swift
//  TipCalculator
//
//  Created by Xinyuan Wang on 11/7/18.
//  Copyright © 2018 Xinyuan Wang. All rights reserved.
//

import Foundation

struct Payment<T> where T: Currency {
    //MARK: Public properties
    typealias CurrencyType = T
    let pay: Currency
    private(set) var tipRate: Float = 0.15
    
    //MARK: Public APIs
    mutating func update(rate: Float) -> Bool {
        guard rate < 1 && rate >= 0 else { return false }
        self.tipRate = rate
        return true
    }
    
    var tip: CurrencyType {
        return CurrencyType(value: pay.value * tipRate)
    }
    
    var totalPay: CurrencyType {
        return CurrencyType(value: (pay.value + tip.value))
    }
    
    //MARK: initMethods
    init(value: Float) {
        pay = CurrencyType(value: value)
    }
    
    init?(value: Float, rate:Float) {
        guard rate >= 0 && rate <= 1 else { return nil }
        self = Payment(value: value)
        _ = self.update(rate: rate)
    }
}
