//
//  HomeViewController.swift
//  DinDinnTest
//
//  Created by Kareem Ahmed on 06/01/2021.
//

import UIKit
import RxSwift
import RxCocoa

protocol HomeView: class {
    func loadOffers(offersList: [Offer])
    func updateCartButton(hide: Bool)
}

class HomeViewController: UIViewController {
    var presenter: HomePresentation?

    @IBOutlet weak var menuItemsTableView: UITableView!
    @IBOutlet weak var cartButton: UIButton!

    private let disposeBag = DisposeBag()
    
    private lazy var offersView: OffersView = {
        let header = OffersView()
        let frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 400)
        header.frame = frame
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.bindTableView()
        self.presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.presenter?.viewWillAppear()
    }
    
    private func bindTableView() {
        self.menuItemsTableView.rx.setDelegate(self).disposed(by: disposeBag)
        self.presenter?.menuItemsDatasource.bind(to: menuItemsTableView.rx.items(cellIdentifier: MenuItemTableViewCell.identifier, cellType: MenuItemTableViewCell.self)) { (row, item, cell) in
            cell.configure(with: item)
            cell.delegate = self
        }.disposed(by: disposeBag)
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

extension HomeViewController: UITableViewDelegate, MenuItemTableViewCellDelegate {
    func addToCart(item: Item) {
        self.presenter?.onAddToCart(menuItem: item)
    }
}

extension HomeViewController: HomeView {
    
    func loadOffers(offersList: [Offer]) {
        self.offersView.configure(offers: offersList)
    }
    
//    func updateMenuItems(with menuItemsList: [Item]) {
//        self.datasource = menuItemsList
//    }
    
    func updateCartButton(hide: Bool) {
        self.cartButton.isHidden = hide
    }
}
