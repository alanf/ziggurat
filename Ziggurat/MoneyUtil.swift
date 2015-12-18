//
//  MoneyUtil.swift
//  Ziggurat
//
//  Created by Alan Fineberg on 11/4/15.
//  Copyright 2015 Square, Inc.
//

import Foundation

/// Using static functions in a Util class (instead of adding this methods to `Money`) guarantees no extraneous state in the model itself.
struct MoneyUtil {

    enum MoneyUtilError: ErrorType {
        case NotParsable
    }
    static func moneyFromString(amount:String, currency:Money.Currency) throws -> Money {
        // Omitted input sanitization for brevity.
        let decimal = NSDecimalNumber(string: amount)
        if decimal == NSDecimalNumber.notANumber() {
            throw MoneyUtilError.NotParsable
        }
        
        // Should take currency into account, for example, we wouldn't multiple by 10^2 for ¥.
        let amountNumber = decimal.decimalNumberByMultiplyingByPowerOf10(2).integerValue
        return Money(amountCents: amountNumber, currency: currency)
    }
    
    static let numberFormatter = NSNumberFormatter()
    static func formattedString(money:Money, locale:NSLocale, truncateFractionalAmountIfZero: Bool = false) throws -> String {
        // The number formatter is cached for performance, and not threadsafe.
        objc_sync_enter(numberFormatter)
        
        defer {
            objc_sync_exit(numberFormatter)
        }
        
        let nf = numberFormatter
        nf.locale = locale
        nf.usesGroupingSeparator = true
        nf.numberStyle = .CurrencyStyle
        
        // Only supporting USD for this example
        nf.currencyCode = "USD"
        nf.multiplier = 0.01
        if let formattedResult = nf.stringFromNumber(Double(money.amountCents ?? 0)) {
            return formattedResult
        }
        throw MoneyUtilError.NotParsable
    }
}