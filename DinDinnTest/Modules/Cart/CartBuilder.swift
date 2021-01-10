//
//  CartBuilder.swift
//  DinDinnTest
//
//  Created by Kareem Ahmed on 10/01/2021.
//

import UIKit

class CartBuilder {
    static func build() -> UIViewController {
        
        let view = DinDinnStoryboard.cart.intiateVC as! CartViewController
        let router = CartRouter(viewController: view)
        let cartInteractor = CartInteractor.shared
        let presenter = CartPresenter(router: router, useCases: (fetchCartItems: cartInteractor.fetchCartItems,
                                                                 deleteCartItem: cartInteractor.deleteCartItem
        ))
        
        presenter.view = view
        view.presenter = presenter
        return view
    }
}
