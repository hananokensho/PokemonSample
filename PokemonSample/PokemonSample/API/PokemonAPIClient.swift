//
//  PokemonAPIClient.swift
//  PokemonSample
//
//  Created by kensho hanano on 2023/01/04.
//

import Foundation

final class PokemonApiClient {
    
    static func fetchPokemonList() async throws -> [Pokemon] {
        let idRange = 1...151
        let urls = try idRange.map { (id: Int) -> URL in
            guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)/") else {
                throw ApiCallError.invalidURL
            }
            return url
        }
        var pokemons: [Pokemon] = try await ApiClient.fetchData(urls: urls)
        pokemons.sort(by: { $0.id < $1.id })
        return pokemons
    }
}
