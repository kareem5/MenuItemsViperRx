//
//  CartInterface.swift
//  DinDinnTest
//
//  Created by Kareem Ahmed on 10/01/2021.
//

protocol CartInterface {
    var deliveryFees: Int { get }
    func addToCart(menuItem: Item)
    func deleteItem(menuItemId: Int)
    func getItems() -> [CartItem]
}
