//
//  Pokemon.swift.swift
//  PokemonSample
//
//  Created by kensho hanano on 2023/01/04.
//

import Foundation

struct Pokemon: Decodable {
    let name: String
    let id: Int
    let sprites: Images
    let types: [Types]
}

struct Images: Codable {
    let frontImage: String
    let shinyImage: String

    enum CodingKeys: String, CodingKey {
        case frontImage = "front_default"
        case shinyImage = "front_shiny"
    }
}

struct Types: Codable {
    let type: Type
}

struct Type: Codable {
    let name: String
}
