//
//  CartPresenter.swift
//  DinDinnTest
//
//  Created by Kareem Ahmed on 10/01/2021.
//

protocol CartPresentation {
    func viewWillAppear()
    func onDeleteItem(cartItemId id: Int)
}

class CartPresenter {
    weak var view: CartView?
    
    typealias UseCases = (
        fetchCartItems: () -> [CartItem],
        deleteCartItem: (_ id: Int) -> Void
    )
    
    private let useCases: UseCases
    private let router: CartRouting
    
    init(router: CartRouting, useCases: UseCases) {
        self.router = router
        self.useCases = useCases
    }
}


extension CartPresenter: CartPresentation {
    
    func viewWillAppear() {
        let cartItems =  self.useCases.fetchCartItems()
        self.view?.loadCartItems(cartItemsList: cartItems)
    }
    
    func onDeleteItem(cartItemId id: Int) {
        self.useCases.deleteCartItem(id)
        let cartItems =  self.useCases.fetchCartItems()
        self.view?.loadCartItems(cartItemsList: cartItems)
        if cartItems.count == 0 {
            self.view?.popToPreviousViewController()

        }
    }
}
