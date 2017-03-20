//
//  RootView.swift
//  Ziggurat
//
//  Created by Alan Fineberg on 11/5/15.
//

import UIKit

/// The view at the root of it all.
class RootView: UIView {
    init() {
        super.init(frame: CGRect.zero)
        
        isUserInteractionEnabled = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
