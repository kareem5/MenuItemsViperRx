//
//  DinDinnStoryboard.swift
//  DinDinnTest
//
//  Created by Kareem Ahmed on 09/01/2021.
//

import UIKit
enum DinDinnStoryboard {
    case home
    case cart
    case menuItemChild
    case pageView
    
    var instance: UIStoryboard {
        switch self {
        case .home, .menuItemChild, .pageView :
            return UIStoryboard.init(name: "Home", bundle: nil)
        case .cart:
            return UIStoryboard.init(name: "Cart", bundle: nil)
        }
    }
    
    var intiateVC: UIViewController {
        switch self {
        case .home:
            return self.instance.instantiateViewController(withIdentifier: RootPageViewController.className)
        case .cart:
            return self.instance.instantiateViewController(withIdentifier: CartViewController.className)
        case .menuItemChild:
            return self.instance.instantiateViewController(withIdentifier: ChildViewController.className)
        case .pageView:
            return self.instance.instantiateViewController(withIdentifier: PageViewController.className)
        }
    }
}
