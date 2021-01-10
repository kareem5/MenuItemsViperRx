//
//  Offer.swift
//  DinDinnTest
//
//  Created by Kareem Ahmed on 09/01/2021.
//

struct Offer {
    let id: Int
    let itemId: Int
    let imageUrl: String
    let title: String
    let description: String
}

extension Offer: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case itemId = "item_id"
        case imageUrl = "image_url"
        case title, description
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.itemId = try container.decodeIfPresent(Int.self, forKey: .itemId) ?? 0
        self.imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl) ?? ""
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
    }
}
