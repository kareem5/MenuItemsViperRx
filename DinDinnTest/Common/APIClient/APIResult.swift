//
//  APIResult.swift
//  DinDinnTest
//
//  Created by Kareem Ahmed on 09/01/2021.
//

import Moya

enum APIResult<T, U> where U: Error {
    case success(T)
    case failure(U)
}

enum APIError: Error {
    case jsonParsingFailure
    case failed(message: String)
    
    var localizedDescription: String {
        switch self {
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .failed(let message): return message
        }
    }
}


extension MoyaError {
    var errorMessage: String {
        
        if let errorInfo = self.errorUserInfo[NSUnderlyingErrorKey] as? MoyaError, let apiError = errorInfo.errorUserInfo[NSUnderlyingErrorKey] as? APIError {
            print("current error: \(apiError.localizedDescription)")
            return apiError.localizedDescription
        }
        
        return self.localizedDescription
    }
}
