//
//  CartPresenterTests.swift
//  Ziggurat
//
//  Created by Alan Fineberg on 12/17/15.
//

import Foundation
import XCTest 
@testable import Ziggurat

class CartPresenterTests: XCTestCase {
    
    class TestCartService: CartService {
        var testCart:Cart? = nil
        override var cart:Cart {
            return testCart ?? super.cart
        }
    }
    
    struct TestCartPresenterContext: CartPresenterContext {
        var cartService:CartService
        var locale:NSLocale { return NSLocale(localeIdentifier: "US") }
    }
    
    func testDiscountViewModel() {
        let service = TestCartService(signal: {})
        let context = TestCartPresenterContext(cartService: service)
        
        let viewModel = CartPresenter.present(context)
        XCTAssertEqual(viewModel.postSubtotalDiscounts.count, 0)
        
        service.testCart = Cart(discounts: [Cart.Discount(UUID: "a", name: "b", amount: Money(amountCents: 123, currency: .USD))])
        let viewModel2 = CartPresenter.present(context)
        XCTAssertEqual(viewModel2.postSubtotalDiscounts.count, 1)

        let discount = viewModel2.postSubtotalDiscounts.first!
        XCTAssertEqual(discount.UUID, "a")
        XCTAssertEqual(discount.displayTitle, "Discount")
        XCTAssertEqual(discount.displayPrice, "$ 1.23")
    }
}
