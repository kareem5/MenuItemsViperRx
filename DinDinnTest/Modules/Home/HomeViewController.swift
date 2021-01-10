//
//  HomeViewController.swift
//  DinDinnTest
//
//  Created by Kareem Ahmed on 06/01/2021.
//

import UIKit

protocol HomeView: class {
    func loadOffers(offersList: [Offer])
    func updateMenuItems(with menuItemsList: [Item])
    func updateCartButton(hide: Bool)
}

class HomeViewController: UIViewController {
    var presenter: HomePresentation?

    @IBOutlet weak var menuItemsTableView: UITableView!
    @IBOutlet weak var cartButton: UIButton!

    
    private lazy var offersView: OffersView = {
        let header = OffersView()
        let frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 400)
        header.frame = frame
        return header
    }()
    
    private var datasource: [Item] = [] {
        didSet {
            if menuItemsTableView.dataSource == nil {
                menuItemsTableView.dataSource = self
                menuItemsTableView.delegate = self
            }
            menuItemsTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.presenter?.viewWillAppear()
    }

    private func setupTableView() {
        self.menuItemsTableView.contentInsetAdjustmentBehavior = .never

        self.menuItemsTableView.tableHeaderView = offersView
        self.menuItemsTableView.register(MenuItemTableViewCell.nib, forCellReuseIdentifier: MenuItemTableViewCell.identifier)
    }
    
    // MARK: IBActions
    @IBAction func cartButtonAction(_ sender: UIButton) {
        self.presenter?.onPressCartButton()
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate, MenuItemTableViewCellDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuItemTableViewCell.identifier, for: indexPath) as? MenuItemTableViewCell else { return UITableViewCell() }
        
        cell.configure(with: self.datasource[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func addToCart(item: Item) {
        self.presenter?.onAddToCart(menuItem: item)
    }
}

extension HomeViewController: HomeView {
    
    func loadOffers(offersList: [Offer]) {
        self.offersView.configure(offers: offersList)
    }
    
    func updateMenuItems(with menuItemsList: [Item]) {
        self.datasource = menuItemsList
    }
    
    func updateCartButton(hide: Bool) {
        self.cartButton.isHidden = hide
    }
}
