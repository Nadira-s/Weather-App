//
//  WeatherResponse.swift
//  Weather App
//
//  Created by Nadira Seitkazy  on 03.02.2026.
//

struct WeatherResponse {
    let city: String
    let temperature: String
    let condition: String
    let humidity: String
    let weatherIcon: String
    let windSpeed: String
    let forecast: [ForecastDay]
}
