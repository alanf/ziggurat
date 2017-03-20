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
        addDiscountButton = UIButton(frame: CGRect.zero)
        addDiscountButton.translatesAutoresizingMaskIntoConstraints = false
        addDiscountButton.titleLabel?.adjustsFontSizeToFitWidth = true
        addDiscountButton.isExclusiveTouch = true
        addDiscountButton.setTitle("Add a Discount", for: UIControlState())
        addDiscountButton.isUserInteractionEnabled = true
        addDiscountButton.backgroundColor = UIColor.blue
        
        cart = UITableView()
        cart.translatesAutoresizingMaskIntoConstraints = false
        cart.tableFooterView = UIView(frame: CGRect.zero)
        cart.backgroundColor = UIColor.lightGray
        
        super.init(frame: CGRect.zero)
        
        isUserInteractionEnabled = true
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(addDiscountButton)
        addSubview(cart)
        
        let views = [
            "cart": cart,
            "addDiscountButton": addDiscountButton,
        ] as [String : Any]
        
        addConstraints(AutolayoutUtil.constraintsWithVisualFormat("V:|-20-[addDiscountButton(40)]-[cart]-20-|", options: .alignAllCenterX, views: views as [String : AnyObject]))
        addConstraints(AutolayoutUtil.constraintsWithVisualFormat("H:|[cart]|", options: .alignAllCenterX, views: views as [String : AnyObject]))
        AutolayoutUtil.centerX(addDiscountButton)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("not supported")
    }
}
