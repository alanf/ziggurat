//
//  CartService.swift
//  Ziggurat
//
//  Created by Alan Fineberg on 11/4/15.
//  Copyright 2015 Square, Inc.
//


import Foundation

/// Used to constrain which functions are visible from a view controller instead of surfacing the entire Service API.
/// To preserve the one-way data flow of Ziggurat app architecture, view controllers are not allowed to query the Service layer.
/// i.e. view controllers can only be told what to do, they never ask--but they inform a service of new input.
protocol DiscountEditable {
    func addAmountDiscount(_ amount: String)
}

/// Manages the Cart model. Contains business logic for manipulating Cart.
/// May also own network requests, trigger writes to disk, setting error states.
/// The gritty details of any i/o live in a Repository class, however.
class CartService: DiscountEditable {

    let signal:SignalUpdate
    init(signal:@escaping SignalUpdate) {
        self.signal = signal
    }
    
    /// This is what's happening in the UI (has no direct knowledge of the view layer though).
    /// This field could be used to indicate whether or not an editing modal should be displayed, as an example.
    /// To reduce the footprint of this Service, this state could be moved into its own separate service.
    /// This may seem like something that should be part of the view model, but the view model is transient and stateless.
    enum CartEditingState {
        case none
        case addingDiscount
    }
    
    fileprivate(set) var cart = Cart()
    fileprivate var cartEditingState:CartEditingState = .none
    
    func editingDiscount(_ isEditing:Bool) {
        precondition(Thread.isMainThread)
        if isEditing {
            cartEditingState = .addingDiscount
        } else if cartEditingState == .addingDiscount {
            cartEditingState = .none
        }
        
        signal()
    }
    
    func addAmountDiscount(_ amount: String) {
        precondition(Thread.isMainThread)
        
        do {
            let discountAmount = try MoneyUtil.moneyFromString(amount, currency: Money.Currency.USD)
            let discount = Cart.Discount(UUID: UUID().uuidString, name: "Coupon", amount:discountAmount)
            cart.addDiscount(discount)
            cartEditingState = .none
        } catch {
            // set invalid discount error on notification service, which would trigger an error notification
        }
        
        signal()
    }
}
