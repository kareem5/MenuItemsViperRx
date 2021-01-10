//
//  RootRootWindowRouter.swift
//  DinDinnTest
//
//  Created by Kareem Ahmed on 09/01/2021.
//

import UIKit

protocol RootWindowRouting {
    func route(to navigationOption: RootWindowRouter.RootNavigationOption)
}

class RootWindowRouter: RootWindowRouting {
        
    private unowned let RootWindow: RootWindow
    private var homeView: UIViewController?

    typealias Submodules = (
        () -> UIViewController
    )
    
    enum RootNavigationOption {
        case home
    }
    
    init(_ RootWindow: RootWindow, submodules: Submodules) {
        self.RootWindow = RootWindow
        self.homeView = submodules()
    }
    
    func route(to navigationOption: RootNavigationOption) {
        var viewController: UIViewController?
        switch navigationOption {
        case .home:
            viewController = self.homeView
        }
        let navigationController = UINavigationController(rootViewController: viewController!)
        self.RootWindow.rootViewController = navigationController
        self.RootWindow.makeKeyAndVisible()
    }

}
