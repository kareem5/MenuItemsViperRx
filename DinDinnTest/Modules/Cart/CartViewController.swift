//
//  CartViewController.swift
//  DinDinnTest
//
//  Created by Kareem Ahmed on 10/01/2021.
//

import UIKit

protocol CartView: class {
    func loadCartItems(cartItemsList: [CartItem])
    func popToPreviousViewController()
}

class CartViewController: UIViewController {

    var presenter: CartPresentation?

    @IBOutlet weak var cartItemsTableView: UITableView!
    
    private var datasource: [CartItem] = [] {
        didSet {
            if cartItemsTableView.dataSource == nil {
                cartItemsTableView.dataSource = self
                cartItemsTableView.delegate = self
            }
            cartItemsTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.presenter?.viewWillAppear()
    }

    private func setupTableView() {
        self.cartItemsTableView.register(CartItemTableViewCell.nib, forCellReuseIdentifier: CartItemTableViewCell.identifier)
    }
}

extension CartViewController: UITableViewDataSource, UITableViewDelegate, CartItemTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartItemTableViewCell.identifier, for: indexPath) as? CartItemTableViewCell else { return UITableViewCell() }
        
        cell.configure(with: self.datasource[indexPath.row])
        cell.delegate = self
        return cell
    }

    func didDelete(cartItemWithId id: Int) {
        self.presenter?.onDeleteItem(cartItemId: id)
    }
}

extension CartViewController: CartView {
    func loadCartItems(cartItemsList: [CartItem]) {
        self.datasource = cartItemsList
    }
    
    func popToPreviousViewController() {
        self.navigationController?.popViewController(animated: true)
    }
}
