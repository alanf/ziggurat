//
//  Money.swift
//  Ziggurat
//
//  Created by Alan Fineberg on 11/4/15.
//  Copyright 2015 Square, Inc.
//

import Foundation

/// Immutable type to represent a monetary amount, with currency information.
/// A more complete implementation might conform to Comparable or Strideable.
struct Money {

    enum Currency: String {
        case USD = "USD"
        case JPY = "JPY"
    }
    
    /// The monetary amount expressed in the currency's lowest denomination (cents for USD, yen for JPY).
    let amountCents:Int
    let currency:Currency
}