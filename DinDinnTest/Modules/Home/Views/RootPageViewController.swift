//
//  RootPageViewController.swift
//  MenuItemsViperRx
//
//  Created by Kareem Ahmed on 16/01/2021.
//

import UIKit
import RxSwift

protocol HomeView: class {
    func updateCartButton(hide: Bool)
}

class RootPageViewController: UIViewController, UIScrollViewDelegate {
    
    enum NotificationObservables: String {
        case childScrollEnabled = "childScrollEnabled"
        
        var notification : Notification.Name  {
            return Notification.Name(rawValue: self.rawValue )
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var pageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var offersView: OffersView!
    
    @IBOutlet weak var cartButton: UIButton!

    
    private let disposeBag = DisposeBag()

    private var pageViewController: PageViewController?
    
    var childViewScrollingEnabled = BehaviorSubject<Bool>(value: false)
    var presenter: HomePresentation?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.contentInsetAdjustmentBehavior = .never
        pageViewHeight.constant = self.view.frame.height + statusBarHeight
        self.scrollView.bounces = false
        self.addPageVC()
        self.bindUI()
        self.presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("status bar height: \(statusBarHeight)")
        self.navigationController?.isNavigationBarHidden = true
        self.presenter?.viewWillAppear()
    }
    
    // MARK: BindingUI
    private func bindUI() {
        self.offersView.configure(dataSource: self.presenter!.offersDatasource)
        
        self.cartButton.rx.tap
            .bind { [weak self] in
                self?.presenter?.onPressCartButton()
            }.disposed(by: disposeBag)
        
        self.childViewScrollingEnabled
            .filter { $0 }
            .subscribe(onNext: { _ in
                self.bindScrollingUI()
        }).disposed(by: disposeBag)
    }
    
    private func bindScrollingUI() {
        NotificationCenter.default.rx
            .notification(NotificationObservables.childScrollEnabled.notification)
            .take(1)
            .subscribe(onNext: { _ in
                self.childViewScrollingEnabled.onNext(false)
            }).disposed(by: disposeBag)
    }
    
    private func addPageVC() {
        if pageViewController == nil {
            pageViewController = DinDinnStoryboard.pageView.intiateVC as? PageViewController
            pageViewController?.presenter = self.presenter
            pageViewController?.childViewScrollingEnabled = self.childViewScrollingEnabled
            self.addChild(pageViewController!)
            self.pageView.addSubview(pageViewController!.view)
            pageViewController!.view.frame = pageView.bounds
            pageViewController!.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            pageViewController!.didMove(toParent: self)
        }
    }
    
    // MARK: ScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            self.childViewScrollingEnabled.onNext(self.scrollView.contentOffset.y >= (450 + statusBarHeight))
        }
    }
}


extension RootPageViewController: HomeView {
    func updateCartButton(hide: Bool) {
        self.cartButton.isHidden = hide
    }
}
