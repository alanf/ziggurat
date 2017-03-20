//
//  CartPresenter.swift
//  Ziggurat
//
//  Created by Alan Fineberg on 11/4/15.
//  Copyright 2015 Square, Inc.
//

import Foundation

/// Contains all the information that a view controller would need to populate and configure its views.
struct CartViewModel {
    /// A cart has many LineItems, they could be discounts, taxes, items, etc.
    /// Essentially, they are each line that you would see printed on a receipt.
    struct LineItem {
        let description: String?
        let displayPrice: String?
        let displayTitle: String
        let UUID: String
    }
    
    let preSubtotalLineItems: [LineItem]
    /// In this example app, only this field is used. The rest are included to forecast what this view model could become.
    let postSubtotalDiscounts: [LineItem]
    let postTaxDiscounts: [LineItem]
    let taxes: [LineItem]
}

/// The dependencies of the CartPresenter are described in this protocol to simplify dependency injection.
protocol CartPresenterContext {
    var cartService:CartService { get }
    var locale:Locale { get }
}

/// Generates a view model for displaying the cart based primarily on querying the CartService.
struct CartPresenter {
    
    /// A stateless function which queries the entities provided in the context to generate a view model.
    static func present(_ context:CartPresenterContext) -> CartViewModel {
        var discounts:[CartViewModel.LineItem] = []
        for discount in context.cartService.cart.discounts {
            let price = try? MoneyUtil.formattedString(discount.amount, locale: context.locale)
            
            let item = CartViewModel.LineItem(
                description: "",
                displayPrice: price,
                displayTitle: "Discount",
                UUID: discount.UUID
            )
            discounts.append(item)
        }
        
        // The unused fields here are to illustrate what a more complex cart would look like.
        return CartViewModel(preSubtotalLineItems: [], postSubtotalDiscounts: discounts, postTaxDiscounts: [], taxes: [])
    }
}
