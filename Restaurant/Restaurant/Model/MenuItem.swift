//
//  MenuItem.swift
//  Restaurant
//
//  Created by Toni Mikut on 04.02.23.
//

import Foundation

struct MenuItem: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case title
        case image
        case price
        case detailText = "description"
        case category
    }
    
    let title: String
    let image: String
    let price: String
    let detailText: String
    let category: String
}
