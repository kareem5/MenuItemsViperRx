//
//  Item.swift
//  DinDinnTest
//
//  Created by Kareem Ahmed on 09/01/2021.
//

struct Item {
    let id: Int
    let name: String
    let description: String
    let weight: Int
    let size: String
    let price: Double
    let imageUrl: String
}

extension Item: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name, description
        case restaurantId = "restaurant_id"
        case imageUrl = "image_url"
        case weight, size, price
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        self.imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl) ?? ""
        
        self.weight = try container.decodeIfPresent(Int.self, forKey: .weight) ?? 0
        self.size = try container.decodeIfPresent(String.self, forKey: .size) ?? ""
        self.price = try container.decodeIfPresent(Double.self, forKey: .price) ?? 0.0

    }
}
