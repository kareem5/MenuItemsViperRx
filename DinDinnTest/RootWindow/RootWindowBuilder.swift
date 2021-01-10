//
//  RootRootWindowBuilder.swift
//  DinDinnTest
//
//  Created by Kareem Ahmed on 09/01/2021.
//

import UIKit

class RootWindowBuilder {
    static func build(frame: CGRect) -> UIWindow {
        let rootWindow = RootWindow(frame: frame)
        let router = RootWindowRouter(rootWindow, submodules: HomeBuilder.build)
        let presenter = RootWindowPresenter(router: router)
        rootWindow.presenter = presenter
        return rootWindow
    }
}
