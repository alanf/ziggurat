//
//  OrderEntryView.swift
//  Ziggurat
//
//  Created by Alan Fineberg on 11/4/15.
//

import UIKit

/// Displays view necessary to ring up an order, namely the cart.
class OrderEntryView: UIView {
    let cart:UITableView
    let addDiscountButton:UIButton
    
    init() {
        addDiscountButton = UIButton(frame: CGRectZero)
        addDiscountButton.translatesAutoresizingMaskIntoConstraints = false
        addDiscountButton.titleLabel?.adjustsFontSizeToFitWidth = true
        addDiscountButton.exclusiveTouch = true
        addDiscountButton.setTitle("Add a Discount", forState: .Normal)
        addDiscountButton.userInteractionEnabled = true
        addDiscountButton.backgroundColor = UIColor.blueColor()
        
        cart = UITableView()
        cart.translatesAutoresizingMaskIntoConstraints = false
        cart.tableFooterView = UIView(frame: CGRectZero)
        cart.backgroundColor = UIColor.lightGrayColor()
        
        super.init(frame: CGRectZero)
        
        userInteractionEnabled = true
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(addDiscountButton)
        addSubview(cart)
        
        let views = [
            "cart": cart,
            "addDiscountButton": addDiscountButton,
        ]
        
        addConstraints(AutolayoutUtil.constraintsWithVisualFormat("V:|-20-[addDiscountButton(40)]-[cart]-20-|", options: .AlignAllCenterX, views: views))
        addConstraints(AutolayoutUtil.constraintsWithVisualFormat("H:|[cart]|", options: .AlignAllCenterX, views: views))
        AutolayoutUtil.centerX(addDiscountButton)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("not supported")
    }
}
