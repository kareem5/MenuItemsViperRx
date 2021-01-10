//
//  MenuAPI.swift
//  DinDinnTest
//
//  Created by Kareem Ahmed on 09/01/2021.
//

import Moya
import RxSwift

protocol MenuAPI {
    
    func fetchOffers() -> Observable<([Offer]?)>
    func fetchMenuItems() -> Observable<([Item]?)>
}
