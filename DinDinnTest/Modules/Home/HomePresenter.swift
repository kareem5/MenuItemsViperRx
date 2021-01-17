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
    func onCategoriesViewControllersfilled()
    func onPressCartButton()
    func onAddToCart(menuItem: Item)
    
    var offersDatasource: PublishSubject<[Offer]> { get }
    var menuItemsDatasource: PublishSubject<[Item]> { get }
    var categoriesDatasource: PublishSubject<[Category]> { get }

}

class HomePresenter {
    weak var view: HomeView?
    
    typealias UseCases = (
        fetchOffers: () -> Observable<([Offer]?)>,
        fetchMenuItems: () -> Observable<([Item]?)>,
        fetchCategories: () -> Observable<([Category]?)>,
        addToCart: (_ menuItem: Item) -> Void,
        fetchCartItems: () -> [CartItem]
    )
    
    private let useCases: UseCases
    private let router: HomeRouting
    
    private let itemsList = PublishSubject<[Item]>()
    private let offersList = PublishSubject<[Offer]>()
    private let categoriesList = PublishSubject<[Category]>()

    private let disposeBag = DisposeBag()
    
    init(router: HomeRouting, useCases: UseCases) {
        self.router = router
        self.useCases = useCases
    }
    
    private func fetchOffers() {
        self.useCases.fetchOffers()
            .subscribe { [weak self] (offersResult) in
                guard let offersResult = offersResult else { return }
                self?.offersList.onNext(offersResult)
            } onError: { (error) in
                print("error: \(error.localizedDescription)")
            }.disposed(by: disposeBag)
    }
    
    private func fetchMenuItems() {
        self.useCases.fetchMenuItems()
            .subscribe { [weak self] (menuItemsResult) in
                guard let menuItemsResult = menuItemsResult else { return }
                self?.itemsList.onNext(menuItemsResult)
            } onError: { (error) in
                print("error: \(error.localizedDescription)")
            }.disposed(by: disposeBag)
    }
    
    private func fetchCategories() {
        self.useCases.fetchCategories()
            .subscribe { [weak self] (categoriesResult) in
                guard let categoriesResult = categoriesResult else { return }
                self?.categoriesList.onNext(categoriesResult)
            } onError: { (error) in
                print("error: \(error.localizedDescription)")
            }.disposed(by: disposeBag)
    }
}


extension HomePresenter: HomePresentation {
    var categoriesDatasource: PublishSubject<[Category]> {
        return categoriesList
    }
    
    var offersDatasource: PublishSubject<[Offer]> {
        return offersList
    }
    
    var menuItemsDatasource: PublishSubject<[Item]> {
        return itemsList
    }
    
    func viewDidLoad() {
        self.view?.updateCartButton(hide: true)
        self.fetchOffers()
        self.fetchCategories()
    }
    
    func viewWillAppear() {
        let cartItems =  self.useCases.fetchCartItems()
        self.view?.updateCartButton(hide: cartItems.count == 0)
    }
    
    func onCategoriesViewControllersfilled() {
        self.fetchMenuItems()
    }
    
    func onPressCartButton() {
        self.router.route(to: .cart)
    }
    
    func onAddToCart(menuItem: Item) {
        self.useCases.addToCart(menuItem)
        self.view?.updateCartButton(hide: false)
    }
}
