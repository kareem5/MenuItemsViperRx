//
//  Category.swift
//  MenuItemsViperRx
//
//  Created by Kareem Ahmed on 17/01/2021.
//

struct Category {
    let id: Int
    let name: String
}

extension Category: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
    }
}
