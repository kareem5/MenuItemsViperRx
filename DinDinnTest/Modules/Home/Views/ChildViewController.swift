//
//  ChildViewController.swift
//  MenuItemsViperRx
//
//  Created by Kareem Ahmed on 16/01/2021.
//

import UIKit
import RxSwift
import RxCocoa
import HMSegmentedControl

class ChildViewController: UIViewController, UITableViewDelegate {
    
    // MARK: Properties
    @IBOutlet weak var menuItemsTableView: UITableView!
    @IBOutlet weak var filterSegmentedControl: HMSegmentedControl!
    
    private let disposeBag = DisposeBag()
    var presenter: HomePresentation?
    var scrollEnabledObservable: BehaviorSubject<Bool>?
    var categoriesList: [Category] = []
    var page: Int?

    // MARK: Init
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTableView()
    }
    
    private func bindTableView() {
        self.menuItemsTableView.register(MenuItemTableViewCell.nib, forCellReuseIdentifier: MenuItemTableViewCell.identifier)
        
        self.scrollEnabledObservable!
            .subscribe(onNext: { [weak self] enabled in
                self?.menuItemsTableView.isScrollEnabled = enabled
            }).disposed(by: disposeBag)
        
        self.menuItemsTableView.rx
            .setDelegate(self).disposed(by: disposeBag)
        
        self.presenter?.menuItemsDatasource
            .map{
                $0.filter{ $0.categoryId == self.categoriesList[self.page!].id }
            }.bind(to: menuItemsTableView.rx
                    .items(cellIdentifier: MenuItemTableViewCell.identifier, cellType: MenuItemTableViewCell.self)) { (row, item, cell) in

                cell.configure(with: item)
                cell.addItem
                    .subscribe(onNext: { addedItem in
                        self.presenter?.onAddToCart(menuItem: addedItem)
                    }).disposed(by: self.disposeBag)
            }.disposed(by: disposeBag)
        
        self.presenter?.menuItemsDatasource.subscribe({_ in
            self.styleFilterSigmentedControl()
        }).disposed(by: disposeBag)
    }
    
    private func styleFilterSigmentedControl() {
        self.filterSegmentedControl.sectionTitles = self.categoriesList.map{ $0.name }
        self.filterSegmentedControl.selectionStyle = .textWidthStripe
        self.filterSegmentedControl.selectionIndicatorLocation = .none
        self.filterSegmentedControl.isVerticalDividerEnabled = false;
        
        self.filterSegmentedControl.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20.0)]
        self.filterSegmentedControl.selectedTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
    }
    
    // MARK: UIScrollView Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.menuItemsTableView {
            guard let scrollEnabledObservable = scrollEnabledObservable else { return }
            do {
                guard let enabled = try? scrollEnabledObservable.value(), menuItemsTableView.contentOffset.y <= 0, enabled else { return }
                NotificationCenter.default.post(name:  RootPageViewController.NotificationObservables.childScrollEnabled.notification, object: nil)
            }
        }
    }
}
