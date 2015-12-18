//
//  RootViewController.swift
//  Ziggurat
//
//  Created by Alan Fineberg on 11/4/15.
//

import UIKit

extension UIViewController {
    func addChild(child: UIViewController) {
        precondition(child.parentViewController == nil, "Child already has a parent")
        addChildViewController(child)
        child.didMoveToParentViewController(self)
    }
}

/// The topmost view controller. In this example app, it's completely occupied by the order entry screen, but it could contain a settings drawer for example.
class RootViewController: UIViewController {

    let viewControllerFactory:ViewControllerFactory
    lazy var orderEntryViewController:OrderEntryViewController = self.viewControllerFactory.orderEntryViewController()
    
    init(viewControllerFactory:ViewControllerFactory) {
        self.viewControllerFactory = viewControllerFactory
        super.init(nibName: nil, bundle: nil)

        loadViewIfNeeded()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = RootView()
        
        addChild(orderEntryViewController)
        view.addSubview(orderEntryViewController.view)
        AutolayoutUtil.fill(orderEntryViewController.view)
    }
    
    func update(viewModel: RootViewModel) {
        orderEntryViewController.update(viewModel.cart)
    }
}

