//
//  APIResponse.swift
//  DinDinnTest
//
//  Created by Kareem Ahmed on 09/01/2021.
//

struct APIResponse<DataParsingType: Decodable>: Responsable  {
    var success: Bool
    var result: DataParsingType?
    var message: String?
}

protocol Responsable: Decodable {
    associatedtype DataParsingType
    
    var success: Bool { get }
    var result: DataParsingType? { get }
    var message: String? { get }
    
}
