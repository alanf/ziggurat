//
//  RootPresenter.swift
//  Ziggurat
//
//  Created by Alan Fineberg on 11/4/15.
//  Copyright 2015 Square, Inc.
//

import Foundation

/// View models have a tree structure, similar in structure to view controllers.
struct RootViewModel {
    let cart:CartViewModel
}

/// This would be composed by multiple "conforms-to" relationships with its subcontexts.
protocol RootPresenterContext: CartPresenterContext {
}

struct RootPresenter {

    static func present(context:RootPresenterContext) -> RootViewModel {
        let cartViewModel = CartPresenter.present(context)
        return RootViewModel(cart: cartViewModel)
    }    
}