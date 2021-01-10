//
//  NibLoadable.swift
//  DinDinnTest
//
//  Created by Kareem Ahmed on 09/01/2021.
//

import Foundation

public protocol NibLoadable: AnyObject {
    static var nibName: String { get }
}

public extension NibLoadable {
    static func loadFromNib() -> Self {
        return loadFromNib(from: Bundle.init(for: self))
    }
    
    static func loadFromNib(from bundle: Bundle) -> Self {
        return bundle.loadNibNamed(self.nibName, owner: nil, options: nil)?.first as! Self
    }
}
