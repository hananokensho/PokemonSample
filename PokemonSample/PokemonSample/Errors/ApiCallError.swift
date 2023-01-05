//
//  ApiCallError.swift
//  PokemonSample
//
//  Created by kensho hanano on 2023/01/04.
//

import Foundation

enum ApiCallError: Error {
    case invalidURL
    case failToFetchData
}
