//
//  MenuEndpoint.swift
//  DinDinnTest
//
//  Created by Kareem Ahmed on 09/01/2021.
//

import Moya

enum MenuEndpoint {
    case fetchOffers
    case fetchMenuItems
    case fetchCategories
}

extension MenuEndpoint: TargetType {
    var environmentBaseURL: String {
        switch MenuService.environment {
        case .production: return "https://run.mocky.io/v3/"
        case .staging: return "https://run.mocky.io/v3/"
        }
    }

    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }

    var path: String {
        switch self {
        case .fetchOffers:
            return "03365c0b-bc8c-4243-ab31-91397da37210"
        case .fetchMenuItems:
            return "c7e86b2c-37c1-4951-b140-686a7cab616b"
        case .fetchCategories:
            return "19eaa32a-21e6-46cb-926e-8bc8ea67f004"
        }
    }

    var method: Moya.Method {
        switch self {
        case .fetchOffers, .fetchMenuItems, .fetchCategories:
            return .get
        }
    }


    var sampleData: Data {
        switch self {
        default:
            return Data()
        }
    }

    var task: Task {
        switch self {
        case .fetchOffers, .fetchMenuItems, .fetchCategories:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        return [
            "Content-type": "application/json"
//            "Authorization": UserManager.shared.user?.token ?? ""
        ]
    }

}
