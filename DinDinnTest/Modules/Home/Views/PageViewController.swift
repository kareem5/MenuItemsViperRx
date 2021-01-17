//
//  PageViewController.swift
//  MenuItemsViperRx
//
//  Created by Kareem Ahmed on 16/01/2021.
//

import UIKit
import Pageboy
import RxSwift

class PageViewController: PageboyViewController, PageboyViewControllerDataSource {
    
    // MARK: Properties
    var presenter: HomePresentation?
    
    var childViewScrollingEnabled: BehaviorSubject<Bool>?

    private let disposeBag = DisposeBag()
    
    /// View controllers that will be displayed in page view controller.
    private var viewControllers: [UIViewController] = []
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        self.isInfiniteScrollEnabled = true
        bindViewControllers()
    }

    private func bindViewControllers() {
        self.presenter?.categoriesDatasource.subscribe(onNext: { [weak self] categories in
            self?.viewControllers.removeAll()
            for i in 0..<categories.count {
                let childVC = DinDinnStoryboard.menuItemChild.intiateVC as! ChildViewController
                childVC.presenter = self?.presenter
                childVC.scrollEnabledObservable = self?.childViewScrollingEnabled
                childVC.page = i
                childVC.categoriesList = categories
                self?.viewControllers.append(childVC)
            }
            self?.reloadData()
            self?.presenter?.onCategoriesViewControllersfilled()
        }).disposed(by: disposeBag)
        
    }
    // MARK: PageboyViewControllerDataSource
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        viewControllers.count // How many view controllers to display in the page view controller.
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        viewControllers[index] // View controller to display at a specific index for the page view controller.
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        nil // Default page to display in the page view controller (nil equals default/first index).
    }
    
    // MARK: Actions
    
//    @IBAction func nextPage(_ sender: UIButton) {
//        scrollToPage(.next, animated: true)
//    }
//
//    @IBAction func previousPage(_ sender: UIButton) {
//        scrollToPage(.previous, animated: true)
//    }
}

extension PageViewController: PageboyViewControllerDelegate {
    func pageboyViewController(_ pageboyViewController: PageboyViewController, didReloadWith currentViewController: UIViewController, currentPageIndex: PageboyViewController.PageIndex) {
        
    }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController, didScrollTo position: CGPoint, direction: PageboyViewController.NavigationDirection, animated: Bool) {
        
    }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController, didScrollToPageAt index: PageboyViewController.PageIndex, direction: PageboyViewController.NavigationDirection, animated: Bool) {
        
    }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController, willScrollToPageAt index: PageboyViewController.PageIndex, direction: PageboyViewController.NavigationDirection, animated: Bool) {
        
    }
    
}
