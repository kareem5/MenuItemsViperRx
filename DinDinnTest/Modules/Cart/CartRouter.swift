//
//  CartRouter.swift
//  DinDinnTest
//
//  Created by Kareem Ahmed on 10/01/2021.
//

import UIKit

protocol CartRouting {
    func route(to navigationOption: CartRouter.RootNavigationOption)
}

class CartRouter {
    private let viewController: UIViewController
    

    enum RootNavigationOption {
        case checkout
    }
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}


extension CartRouter: CartRouting {
    func route(to navigationOption: RootNavigationOption) {
        switch navigationOption {
        case .checkout:
            break
        }
    }
}
