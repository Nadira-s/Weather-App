//
//  APIConfig.swift
//  Weather App
//
//  Created by Nadira Seitkazy  on 23.02.2026.
//


import Foundation
import Alamofire

public struct APIConfig {
    public let baseURL: URL
    public let timeout: TimeInterval
    public let headers: HTTPHeaders

    public init(baseURL: URL, timeout: TimeInterval = 30, headers: HTTPHeaders = [:]) {
        self.baseURL = baseURL
        self.timeout = timeout
        self.headers = headers
    }

    public static let `default`: APIConfig = {
        // TODO: Point this to your real API base URL
        let url = URL(string: "https://api.openweathermap.org")!
        var headers: HTTPHeaders = ["Accept": "application/json"]
        return APIConfig(baseURL: url, timeout: 30, headers: headers)
    }()
}