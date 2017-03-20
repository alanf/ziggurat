//
//  Cart.swift
//  Ziggurat
//
//  Created by Alan Fineberg on 11/4/15.
//  Copyright 2015 Square, Inc.
//

import Foundation

/// This is the model which represents the "shopping cart."
/// In a non-example app, it may support serialization, e.g. to a protobuf.
struct Cart {
    
    /// Discount represents a coupon or other form of savings applied to the cart.
    struct Discount {
        let UUID:String
        let name:String
        let amount:Money
    }
    
    /// A cart can have multiple discounts applied to it.
    fileprivate(set) var discounts:[Discount] = []
    
    /// Add a discount to the list of cart discounts.
    mutating func addDiscount(_ discount:Discount) {
        discounts.append(discount)
    }
    
    /// Remove all discounts with a matching UUID.
    mutating func removeDiscount(_ UUID:String) {
        discounts = discounts.filter { $0.UUID != UUID }
    }
}
