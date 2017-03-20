//
//  OrderEntryViewController.swift
//  Ziggurat
//
//  Created by Alan Fineberg on 11/4/15.
//

import Foundation
import UIKit

fileprivate let cartCellReuseIdentifier = "CartCell"

/// Manages the views necessary to ring up an individual order.
class OrderEntryViewController: UIViewController {
  
  fileprivate var cartItems:UITableViewDataSource?

  
  let discountEditService:DiscountEditable
  lazy var orderEntryView = OrderEntryView()
  
  init(discountEditService:DiscountEditable) {
    self.discountEditService = discountEditService
    super.init(nibName: nil, bundle: nil)
    
    loadViewIfNeeded()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    view = orderEntryView
    
    orderEntryView.addDiscountButton.addTarget(self, action: #selector(OrderEntryViewController.addDiscount), for: .touchUpInside)
    orderEntryView.cart.register(UITableViewCell.self, forCellReuseIdentifier: cartCellReuseIdentifier)
  }
  
  func update(_ viewModel:CartViewModel) {
    cartItems = CartTableViewDataSource(items: [], discounts: viewModel.postSubtotalDiscounts, taxes: [])
    orderEntryView.cart.dataSource = cartItems
    orderEntryView.cart.reloadData()
  }
  
  func addDiscount() {
    // This value would normally come from a text field in a modal.
    // Omitting to save time, this sample app is large enough already...
    discountEditService.addAmountDiscount("1.24")
  }
  
  // MARK: - UITableViewDataSource
  class CartTableViewDataSource : NSObject, UITableViewDataSource {
    typealias LineItems = [CartViewModel.LineItem]
    fileprivate let sections:[LineItems]
    
    init(items:LineItems, discounts:LineItems, taxes:LineItems) {
      var sections:[LineItems] = []
      if items.count > 0 {
        sections.append(items)
      }
      if discounts.count > 0 {
        sections.append(discounts)
      }
      if taxes.count > 0 {
        sections.append(taxes)
      }
      self.sections = sections
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
      return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: cartCellReuseIdentifier, for:indexPath)
      let lineItem = sections[indexPath.section][indexPath.row]
      
      if let price = lineItem.displayPrice {
        cell.textLabel?.text = "\(lineItem.displayTitle) \(price)"
      } else {
        cell.textLabel?.text = lineItem.displayTitle
      }
      
      return cell
    }
  }
}
