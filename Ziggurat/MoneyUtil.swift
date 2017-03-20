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
  
  enum MoneyUtilError: Error {
    case notParsable
  }
  static func moneyFromString(_ amount:String, currency:Money.Currency) throws -> Money {
    // Omitted input sanitization for brevity.
    let decimal = NSDecimalNumber(string: amount)
    if decimal == NSDecimalNumber.notANumber {
      throw MoneyUtilError.notParsable
    }
    
    // Should take currency into account, for example, we wouldn't multiple by 10^2 for ¥.
    let amountNumber = decimal.multiplying(byPowerOf10: 2).intValue
    return Money(amountCents: amountNumber, currency: currency)
  }
  
  static let numberFormatter = NumberFormatter()
  static func formattedString(_ money:Money, locale:Locale, truncateFractionalAmountIfZero: Bool = false) throws -> String {
    // The number formatter is cached for performance, and not threadsafe.
    objc_sync_enter(numberFormatter)
    
    defer {
      objc_sync_exit(numberFormatter)
    }
    
    let nf = numberFormatter
    nf.locale = locale
    nf.usesGroupingSeparator = true
    nf.numberStyle = .currency
    
    // Only supporting USD for this example
    nf.currencyCode = "USD"
    nf.multiplier = 0.01
    if let formattedResult = nf.string(from: NSNumber(value: Double(money.amountCents))) {
      return formattedResult
    }
    throw MoneyUtilError.notParsable
  }
}
