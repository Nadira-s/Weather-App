//
//  WeatherModels.swift
//  Weather App
//
//  Created by Nadira Seitkazy on 17.02.2026.
//

import Foundation

struct ForecastDay: Identifiable {
    let id = UUID()
    let city: String
    let date: String
    let day: String
    let temperature: String
    let condition: String
    let icon: String
    let wind: String
    let humidity: String
}

struct HourlyForecast: Identifiable {
    let id = UUID()
    let time: String
    let temperature: Int
    let icon: String
}

struct WeatherInfoItem: Identifiable {
    let id = UUID()
    let type: WeatherInfoType
    let title: String
    let value: String
    let subtitle: String?
    let weatherIcon: String?
}

enum WeatherInfoType {
    case wind
    case humidity
    case uvIndex
}
