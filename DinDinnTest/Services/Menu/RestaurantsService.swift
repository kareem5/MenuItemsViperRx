//
//  RestaurantsService.swift
//  DinDinnTest
//
//  Created by Kareem Ahmed on 09/01/2021.
//

import Moya

class RestaurantsService: APIClient {
    internal lazy var provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])

    static let environment: APIEnvironment = .staging
}

extension RestaurantsService: RestaurantsAPI {
    func fetchOffers(completion: @escaping (APIResult<[Offer]?, MoyaError>) -> Void) {
        fetch(with: <#T##TargetType#>, completion: <#T##(APIResult<Decodable, MoyaError>) -> Void#>)
    }
}
