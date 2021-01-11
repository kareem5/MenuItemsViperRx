//
//  HomePresenter.swift
//  DinDinnTest
//
//  Created by Kareem Ahmed on 09/01/2021.
//
import Moya
import RxSwift

protocol HomePresentation {
    func viewDidLoad()
    func viewWillAppear()
    func onPressCartButton()
    func onAddToCart(menuItem: Item)
    
    var menuItemsDatasource: PublishSubject<[Item]> { get }
}

class HomePresenter {
    weak var view: HomeView?
    
    typealias UseCases = (
        fetchOffers: () -> Observable<([Offer]?)>,
        fetchMenuItems: () -> Observable<([Item]?)>,
        addToCart: (_ menuItem: Item) -> Void,
        fetchCartItems: () -> [CartItem]
    )
    
    private let useCases: UseCases
    private let router: HomeRouting
    
    private let itemsList = PublishSubject<[Item]>()
    private let disposeBag = DisposeBag()
    
    init(router: HomeRouting, useCases: UseCases) {
        self.router = router
        self.useCases = useCases
    }
}


extension HomePresenter: HomePresentation {
    
    var menuItemsDatasource: PublishSubject<[Item]> {
        return itemsList
    }
    
    func viewDidLoad() {
        self.view?.updateCartButton(hide: true)
        
        self.useCases.fetchOffers()
            .subscribe { [weak self] (offersResult) in
                guard let offersResult = offersResult else { return }
                print("offersResult: \(offersResult)")
                self?.view?.loadOffers(offersList: offersResult)
            } onError: { (error) in
                print("error: \(error.localizedDescription)")
            }.disposed(by: disposeBag)
        
        
        self.useCases.fetchMenuItems()
            .subscribe { [weak self] (menuItemsResult) in
                guard let menuItemsResult = menuItemsResult else { return }
                print("menuItemsResult: \(menuItemsResult)")
                self?.itemsList.onNext(menuItemsResult)
            } onError: { (error) in
                print("error: \(error.localizedDescription)")
            }.disposed(by: disposeBag)
    }
    
    func viewWillAppear() {
        let cartItems =  self.useCases.fetchCartItems()
        self.view?.updateCartButton(hide: cartItems.count == 0)
    }
    
    func onPressCartButton() {
        self.router.route(to: .cart)
    }
    
    func onAddToCart(menuItem: Item) {
        self.useCases.addToCart(menuItem)
        self.view?.updateCartButton(hide: false)
    }
}
