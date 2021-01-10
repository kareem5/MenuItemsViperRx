//
//  HomeInteractor.swift
//  DinDinnTest
//
//  Created by Kareem Ahmed on 09/01/2021.
//
import RxSwift

class HomeInteractor {
    private var service: MenuAPI
    private var cartService: CartInterface

    
    static let shared : HomeInteractor = HomeInteractor()

    private init(service: MenuAPI = MenuService(), cartService: CartInterface = CartService.shared) {
        self.service = service
        self.cartService = cartService
    }
}

extension HomeInteractor {
    func fetchOffers() -> Observable<([Offer]?)> {
        return self.service.fetchOffers()
    }
    
    func fetchMenuItems() -> Observable<([Item]?)> {
        return self.service.fetchMenuItems()
    }
    
    func fetchCartItems() -> [CartItem] {
        self.cartService.getItems()
    }
    
    func addToCart(menuItem: Item) {
        self.cartService.addToCart(menuItem: menuItem)
    }
}
