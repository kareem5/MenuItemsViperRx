//
//  CartInteractor.swift
//  DinDinnTest
//
//  Created by Kareem Ahmed on 10/01/2021.
//

class CartInteractor {
    private var service: CartInterface

    static let shared : CartInteractor = CartInteractor()

    private init(service: CartInterface = CartService.shared) {
        self.service = service
    }
}

extension CartInteractor {
    func fetchCartItems() -> [CartItem] {
        self.service.getItems()
    }
    
    func deleteCartItem(withMenuItemId id: Int) {
        self.service.deleteItem(menuItemId: id)
    }
}
