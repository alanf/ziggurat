//
//  AppContext.swift
//  Ziggurat
//
//  Created by Alan Fineberg on 11/4/15.
//  Copyright 2015 Square, Inc.
//

import Foundation
import UIKit

/// This protocol instantiates view controllers to allow for simpler dependency injection.
/// In this example app, only one view controller is used, so there's not much to it.
protocol ViewControllerFactory {
    func orderEntryViewController() -> OrderEntryViewController
}

/// `AppContext` is the object graph for the app. It's designed with dependency injection in mind, but doesn't use a dedicated DI framework.
///
/// Consider this AppContext just one way to do DI, another approach is simply passing smaller objects into the initializers of larger objects, forcing a heirarchical, directed ownership graph which is owned by the `AppDelegate` instead of an `AppContext` which "owns" *everything* in a flattened structure.
///
/// My personal goals for DI were:
/// o Does not rely on runtime or force-casting
/// o Does not rely on metaprogramming or configuration files
/// o Simple to understand
///
/// The `AppContext` approach checks the above boxes, but its downsides are:
/// o It's a class that can grow very large if not broken up.
/// o It doesn't mandate a directed graph, so it's possible to create circular dependencies (break these with closures).
/// o There is not a strict inversion of control, as is common in many DI constructions.
///
/// There are many approaches to dependency injection, and plenty more to say on the subject, but for the sake of brevity, let's move on...
class AppContext: RootPresenterContext, ViewControllerFactory {
    
    private(set) lazy var window = UIWindow()
    private(set) lazy var locale = NSLocale.currentLocale()
    
    private(set) lazy var rootViewController:RootViewController = RootViewController(viewControllerFactory: self)
    
    private(set) lazy var cartService:CartService = CartService(signal: self.renderer.render)
    
    private(set) lazy var renderer:RootViewRenderer = RootViewRenderer(window: self.window, presenterContext: self)
    
    private(set) lazy var httpRepository:HTTPRepository = HTTPRepository(session: self.session)
    private(set) lazy var session:NSURLSession = NSURLSession(
        configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
        delegate: nil,
        delegateQueue: NSOperationQueue()
    )
    
    func orderEntryViewController() -> OrderEntryViewController {
        return OrderEntryViewController(discountEditService: cartService)
    }
}