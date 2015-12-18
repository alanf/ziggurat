//
//  CartServiceTests.swift
//  Ziggurat
//
//  Created by Alan Fineberg on 12/17/15.
//  Copyright 2015 Square, Inc.
//

import Foundation
import XCTest
@testable import Ziggurat

class CartServiceTests: XCTestCase {
 
    func testAddingDicount() {
        let service = CartService(signal: {})
        XCTAssertEqual(service.cart.discounts.count, 0)
        
        service.addAmountDiscount("5.55")
        XCTAssertEqual(service.cart.discounts.count, 1)
        XCTAssertEqual(service.cart.discounts.first!.amount.amountCents, 555)
    }
}