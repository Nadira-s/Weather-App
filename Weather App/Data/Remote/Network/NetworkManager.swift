//
//  NetworkManager.swift
//  Weather App
//
//  Created by Nadira Seitkazy  on 19.02.2026.
//

import Foundation


final class NetworkManager {

    func request<T: Decodable>(
        endpoint: URLRequest
    ) async throws -> T {

        let (data, response) = try await URLSession.shared.data(for: endpoint)

        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}
