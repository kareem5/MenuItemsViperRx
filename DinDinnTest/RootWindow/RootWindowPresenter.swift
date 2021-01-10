//
//  RootWindowPresenter.swift
//  DinDinnTest
//
//  Created by Kareem Ahmed on 09/01/2021.
//

protocol RootWindowPresentation {
    func initialize()
}


class RootWindowPresenter {
    
    private let router: RootWindowRouting
    
    init(router: RootWindowRouter) {
        self.router = router
        self.initialize()
    }
}

extension RootWindowPresenter: RootWindowPresentation {
    func initialize() {
        self.router.route(to: .home)
    }
}
