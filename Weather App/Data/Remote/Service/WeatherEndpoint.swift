//
//  WeatherEndpoint.swift
//  Weather App
//
//  Created by Nadira Seitkazy  on 19.02.2026.
//

import Foundation

enum WeatherEndpoint {

    case current(city: String)
    case forecast(city: String)

    private var apiKey: String { Strings.apiKey }

    var urlRequest: URLRequest {
        let base = "https://api.openweathermap.org/data/2.5"

        switch self {

        case .current(let city):
            let url =
            "\(base)/weather?q=\(city)&units=metric&appid=\(apiKey)"
            return URLRequest(url: URL(string: url)!)

        case .forecast(let city):
            let url =
            "\(base)/forecast?q=\(city)&units=metric&appid=\(apiKey)"
            return URLRequest(url: URL(string: url)!)
        }
    }
}
