//
//  APIRouter.swift
//  Weather App
//
//  Created by Nadira Seitkazy  on 23.02.2026.
//


import Foundation
import Alamofire

public enum APIRouter: URLRequestConvertible {
    case currentWeather(city: String, apiKey: String)
    case forecast(city: String, apiKey: String)

    // MARK: - Endpoint Path
    private var path: String {
        switch self {
        case .currentWeather:
            return "/data/2.5/weather"
        case .forecast:
            return "/data/2.5/forecast"
        }
    }

    // MARK: - HTTP Method
    private var method: HTTPMethod {
        switch self {
        case .currentWeather, .forecast:
            return .get
        }
    }

    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .currentWeather(let city, let apiKey), .forecast(let city, let apiKey):
            return [
                "q": city,
                "appid": apiKey,
                "units": "metric"
            ]
        }
    }

    // MARK: - Convert to URLRequest
    public func asURLRequest() throws -> URLRequest {
        // Step 1: Get base URL
        let baseURL = APIConfig.default.baseURL
        // Step 2: Append endpoint path
        let url = baseURL.appendingPathComponent(path)
        
        // Step 3 & 4: Create request
        var urlRequest = URLRequest(url: url)
        
        // Step 5: Set HTTP method (GET, POST, etc.)
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = APIConfig.default.timeout
        
        // Step 6: Add required headers
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        APIConfig.default.headers.forEach { header in
            urlRequest.addValue(header.value, forHTTPHeaderField: header.name)
        }
        
        // Step 7: Pick the correct encoding strategy depending on HTTP method
        let encoding: ParameterEncoding = {
            switch method {
            case .get, .delete:
                return URLEncoding.default
            case .post, .put, .patch:
                return JSONEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        // Step 8: Apply encoding (attach parameters if any)
        return try encoding.encode(urlRequest, with: parameters)
    }
}
