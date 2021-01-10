//
//  HomeRouter.swift
//  DinDinnTest
//
//  Created by Kareem Ahmed on 09/01/2021.
//

import UIKit

protocol HomeRouting {
    func route(to navigationOption: HomeRouter.RootNavigationOption)
}

class HomeRouter {
    private let viewController: UIViewController
       
    private let submodules: Submodules
    private lazy var cartView =  submodules.cartModule()
    enum RootNavigationOption {
        case cart
    }
    
    typealias Submodules = (cartModule: () -> UIViewController, ())
    
    init(viewController: UIViewController, submodules: Submodules) {
        self.viewController = viewController
        self.submodules = submodules
    }
}


extension HomeRouter: HomeRouting {
    func route(to navigationOption: RootNavigationOption) {
        switch navigationOption {
        case .cart:
            viewController.navigationController?.pushViewController(cartView, animated: true)
            break
        }
    }
}
