//
//  APIClientProtocol.swift
//  Weather App
//
//  Created by Nadira Seitkazy  on 23.02.2026.
//


import Foundation
import Alamofire

public protocol APIClientProtocol {
    func request<T: Decodable>(_ convertible: URLRequestConvertible, decoder: JSONDecoder) async throws -> T
    func requestVoid(_ convertible: URLRequestConvertible) async throws
}

public final class APIClient: APIClientProtocol {
    private let session: Session
    private let defaultDecoder: JSONDecoder

    public init(session: Session = .default, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.defaultDecoder = decoder
        self.defaultDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    public func request<T: Decodable>(_ convertible: URLRequestConvertible, decoder: JSONDecoder = JSONDecoder()) async throws -> T {
        let decoderToUse: JSONDecoder = {
            let d = decoder
            if case .useDefaultKeys = d.keyDecodingStrategy {
                d.keyDecodingStrategy = .convertFromSnakeCase
            }
            return d
        }()

        return try await withCheckedThrowingContinuation { continuation in
            session.request(convertible)
                .validate()
                .responseDecodable(of: T.self, decoder: decoderToUse) { response in
                    switch response.result {
                    case .success(let model):
                        continuation.resume(returning: model)
                    case .failure(let error):
                        continuation.resume(throwing: APIError.fromAFError(error, data: response.data))
                    }
                }
        }
    }

    public func requestVoid(_ convertible: URLRequestConvertible) async throws {
        try await withCheckedThrowingContinuation { continuation in
            session.request(convertible)
                .validate()
                .response { response in
                    switch response.result {
                    case .success:
                        continuation.resume()
                    case .failure(let error):
                        continuation.resume(throwing: APIError.fromAFError(error, data: response.data))
                    }
                }
        }
    }
}

public enum APIError: LocalizedError {
    case network(underlying: Error)
    case server(message: String)
    case decoding(underlying: Error)

    public var errorDescription: String? {
        switch self {
        case .network(let err): return "Network error: \(err.localizedDescription)"
        case .server(let message): return "Server error: \(message)"
        case .decoding(let err): return "Decoding error: \(err.localizedDescription)"
        }
    }

    static func fromAFError(_ error: AFError, data: Data?) -> APIError {
        if let underlying = error.underlyingError { return .network(underlying: underlying) }
        if let data, let message = String(data: data, encoding: .utf8), !message.isEmpty { return .server(message: message) }
        return .network(underlying: error)
    }
}
