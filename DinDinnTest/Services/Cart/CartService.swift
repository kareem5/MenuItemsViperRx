//
//  CartService.swift
//  DinDinnTest
//
//  Created by Kareem Ahmed on 10/01/2021.
//

import Foundation

class CartService: CartInterface {
    
    static let shared : CartService = CartService()

    var deliveryFees: Int { return 161 }
    private var cartItems: [CartItem] = []
    
    func addToCart(menuItem: Item) {
        if let index = cartItems.firstIndex(where: { $0.menuItem.id == menuItem.id }) {
            cartItems[index].count += 1
        } else {
            let cartItem = CartItem(menuItem: menuItem, count: 1)
            self.cartItems.append(cartItem)
        }
    }
    
    func deleteItem(menuItemId: Int) {
        if let index = cartItems.firstIndex(where: { $0.menuItem.id == menuItemId }) {
            cartItems.remove(at: index)
        }
    }
    
    func getItems() -> [CartItem] {
        return cartItems
    }
}
