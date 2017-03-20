//
//  AppDelegate.swift
//  Ziggurat
//
//  Created by Alan Fineberg on 11/4/15.
//  Copyright 2015 Square, Inc.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    /// The object graph used to bootstrap the application.
    let context = AppContext()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let window = context.window
        window.makeKeyAndVisible()
        window.frame = UIScreen.main.bounds
        window.becomeFirstResponder()
        window.rootViewController = context.rootViewController
        
        /// First render.
        context.renderer.render()
        
        return true
    }
}

