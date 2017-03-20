//
//  RootViewRenderer.swift
//  Ziggurat
//
//  Created by Alan Fineberg on 11/4/15.
//  Copyright 2015 Square, Inc.
//

import Foundation
import UIKit

/// A function used to inform the renderer that updates are ready.
typealias SignalUpdate = () -> ()

/// Responsible for creating a view model tree and updating the view controllers.
class RootViewRenderer {
    let window:UIWindow
    let rootPresenterContext:RootPresenterContext
    
    init(
        window:UIWindow,
        presenterContext:RootPresenterContext
        )
    {
        self.window = window
        self.rootPresenterContext = presenterContext
    }
    
    func render() {
        // For production, there's logic to remove extraneous render calls in a single run loop.
        DispatchQueue.main.async {
            if let rvc = self.window.rootViewController as? RootViewController {
                let rootViewModel = RootPresenter.present(self.rootPresenterContext)
                rvc.update(rootViewModel)
            }
        }
    }
}
