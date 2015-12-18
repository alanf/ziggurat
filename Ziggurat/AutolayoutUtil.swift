//
//  AutolayoutUtil.swift
//  Ziggurat
//
//  Created by Alan Fineberg on 11/4/15.
//  Copyright 2015 Square, Inc.
//

import Foundation
import UIKit

/// Example of a Util class, which are essentially small libraries.
/// For Autolayout, it's also worth checking out: https://github.com/robb/Cartography
struct AutolayoutUtil {
    /// Convenience function to create constraints with all necessary properties and an identifier
    static func constraintsWithVisualFormat(
        format: String,
        options: NSLayoutFormatOptions = [],
        metrics: [String : CGFloat]? = [:],
        views: [String : AnyObject],
        identifier: String = "",
        priority: Float? = nil,
        file: String = __FILE__,
        line: Int = __LINE__) -> [NSLayoutConstraint] {
            let filename = (file.componentsSeparatedByString("/").last!).componentsSeparatedByString(".").first!
            let identifier = (identifier == "" ? String(line) : identifier)
            let constraints = NSLayoutConstraint.constraintsWithVisualFormat(format, options: options, metrics: metrics, views: views)
            for constraint in constraints {
                constraint.identifier = "\(filename):\(identifier)"
                if let priority = priority {
                    constraint.priority = priority
                }
            }
            return constraints
    }
    
    /// Convenience function to create a constraint with all necessary properties and an identifier
    static func constraint(
        item item: UIView,
        attribute: NSLayoutAttribute,
        relatedBy: NSLayoutRelation,
        toItem: UIView? = nil,
        attribute toAttribute: NSLayoutAttribute = .NotAnAttribute,
        multiplier: CGFloat = 1.0,
        constant: CGFloat = 0.0,
        identifier: String = "",
        priority: Float = 1000.0,
        file: String = __FILE__,
        line: Int = __LINE__) -> NSLayoutConstraint {
            let filename = (file.componentsSeparatedByString("/").last!).componentsSeparatedByString(".").first!
            let identifier = (identifier == "" ? String(line) : identifier)
            let constraint = NSLayoutConstraint(item: item, attribute: attribute, relatedBy: relatedBy, toItem: toItem, attribute: toAttribute, multiplier: multiplier, constant: constant)
            constraint.identifier = "\(filename):\(identifier)"
            constraint.priority = priority
            return constraint
    }
    
    /// Convenience function to setup a CenterX equals NSLayoutConstraint. Caller must install it on a shared superview of the views.
    static func centerXConstraint(view: UIView, relativeTo: UIView, file: String = __FILE__, line: Int = __LINE__) -> NSLayoutConstraint {
        return self.constraint(item: view, attribute: .CenterX, relatedBy: .Equal, toItem: relativeTo, attribute: .CenterX, file: file, line: line)
    }
    
    /// Centers view inside its superview.
    static func centerX(view: UIView, file: String = __FILE__, line: Int = __LINE__) {
        if let superview = view.superview {
            superview.addConstraint(centerXConstraint(view, relativeTo: superview, file: file, line: line))
        } else {
            fatalError("view must have superview to center within")
        }
    }
    
    /// Convenience function to setup a CenterY equals NSLayoutConstraint. Caller must install it on a shared superview of the views.
    static func centerYConstraint(view: UIView, relativeTo: UIView, file: String = __FILE__, line: Int = __LINE__) -> NSLayoutConstraint {
        return constraint(item: view, attribute: .CenterY, relatedBy: .Equal, toItem: relativeTo, attribute: .CenterY, file: file, line: line)
    }
    
    /// Centers view inside its superview.
    static func centerY(view: UIView, file: String = __FILE__, line: Int = __LINE__) {
        if let superview = view.superview {
            superview.addConstraint(centerYConstraint(view, relativeTo: superview, file: file, line: line))
        } else {
            fatalError("view must have superview to center within")
        }
    }
    
    /// Sets view's leading and trailing edges to its superview's.
    static func fillX(view: UIView, file: String = __FILE__, line: Int = __LINE__) {
        if let superview = view.superview {
            let views = ["view": view]
            superview.addConstraints(constraintsWithVisualFormat("|[view]|", views: views, file: file, line: line))
        } else {
            fatalError("view must have superview to fill to")
        }
    }
    
    /// Sets view's leading and trailing edges to its superview's.
    static func fillY(view: UIView, file: String = __FILE__, line: Int = __LINE__) {
        if let superview = view.superview {
            let views = ["view": view]
            superview.addConstraints(constraintsWithVisualFormat("V:|[view]|", views: views, file: file, line: line))
        } else {
            fatalError("view must have superview to fill to")
        }
    }
    
    /// Fills view horizontally and vertically inside its superview.
    static func fill(view: UIView, file: String = __FILE__, line: Int = __LINE__) {
        fillX(view, file: file, line: line)
        fillY(view, file: file, line: line)
    }
}