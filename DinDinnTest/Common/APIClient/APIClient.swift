//
//  APIClient.swift
//  DinDinnTest
//
//  Created by Kareem Ahmed on 09/01/2021.
//

import Moya
import RxSwift

enum APIEnvironment {
    case staging
    case production
}

protocol APIClient {
    var provider: MoyaProvider<MultiTarget> { get }
    func fetch<T: Decodable>(with target: TargetType) -> Observable<(T)>
}

extension APIClient {
    
    func fetch<T: Decodable>(with target: TargetType) -> Observable<(T)> {
        return Observable<(T)>.create { (subscriber) -> Disposable in
            provider.request(MultiTarget(target)) { result in
                switch result {
                case .success(let response):
                    do {
                        print("response: \(response)")
                        let result = try JSONDecoder().decode(APIResponse<T>.self, from: response.data)
                        print("result: \(result)")
                        if result.success {
                            if let resultData = result.result {
                                subscriber.onNext(resultData)
                                subscriber.onCompleted()
                            } else {
                                let err = APIError.jsonParsingFailure
                                subscriber.onError(err)
                            }
                        } else {
                            let err = APIError.failed(message: result.message ?? "Something went wrong!")
                            print(err.localizedDescription)
                            let moError = MoyaError.underlying(err, nil)
                            throw moError
                        }
                        
                        
                    } catch let err {
                        print("error: \(err)")
                        subscriber.onError(err)
                    }
                    break
                    
                case .failure(let error):
                    print("error: \(error)")
                    subscriber.onError(error)
                }
            }
            
            return Disposables.create {}
        }
    }
}
