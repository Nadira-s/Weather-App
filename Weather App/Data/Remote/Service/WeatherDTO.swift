//
//  WeatherDTO.swift
//  Weather App
//
//  Created by Nadira Seitkazy on 11.03.2026.
//

import Foundation

public struct WeatherDTO: Decodable {
    public let name: String
    public let main: Main
    public let weather: [Weather]
    public let wind: Wind

    public struct Main: Decodable {
        public let temp: Double
        public let humidity: Int
    }

    public struct Weather: Decodable {
        public let main: String
        public let description: String
    }

    public struct Wind: Decodable {
        public let speed: Double
    }
}

public struct ForecastDTO: Decodable {
    public struct Item: Decodable {
        public let dt: TimeInterval
        public let main: Main
        public let weather: [Weather]
        public let wind: Wind

        public struct Main: Decodable {
            public let temp: Double
            public let humidity: Int
        }

        public struct Weather: Decodable {
            public let main: String
            public let description: String
        }

        public struct Wind: Decodable {
            public let speed: Double
        }
    }
    public let list: [Item]
}
