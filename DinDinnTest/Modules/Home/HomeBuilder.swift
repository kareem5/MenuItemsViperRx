//
//  HomeBuilder.swift
//  DinDinnTest
//
//  Created by Kareem Ahmed on 09/01/2021.
//

import UIKit
import Moya

class HomeBuilder {
    static func build() -> UIViewController {
        
        let view = DinDinnStoryboard.home.intiateVC as! HomeViewController
        let router = HomeRouter(viewController: view, submodules: (cartModule: CartBuilder.build, ()))
        let homeInteractor = HomeInteractor.shared
        let presenter = HomePresenter(router: router,
                                      useCases: (fetchOffers: homeInteractor.fetchOffers,
                                                 fetchMenuItems: homeInteractor.fetchMenuItems,
                                                 addToCart: homeInteractor.addToCart,
                                                 fetchCartItems: homeInteractor.fetchCartItems))
        presenter.view = view
        view.presenter = presenter
        return view
    }
}
