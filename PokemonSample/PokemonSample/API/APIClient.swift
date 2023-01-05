//
//  APIClient.swift
//  PokemonSample
//
//  Created by kensho hanano on 2023/01/04.
//

import Foundation

struct ApiClient {

    static func fetchData<T: Decodable>(urls: [URL]) async throws -> [T] {
        var results = [T]()

        try await withThrowingTaskGroup(of: (Data, URLResponse).self) { group in
            for url in urls {
                group.addTask(priority: nil) {
                    try await URLSession.shared.data(from: url)
                }
            }
            for try await (data, _) in group {
                let result = try JSONDecoder().decode(T.self, from: data)
                results.append(result)
            }
        }
        return results
    }
}
