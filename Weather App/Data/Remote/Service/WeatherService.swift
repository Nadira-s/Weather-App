//
//  WeatherService.swift
//  Weather App
//
//  Created by Nadira Seitkazy on 03.02.2026.
//
import Foundation

protocol WeatherService {
    func fetchWeather(for city: String) async throws -> WeatherDTO
    func fetchForecast(for city: String) async throws -> ForecastDTO
    func fetchHourlyForecast(for city: String) async throws -> ForecastDTO
}

final class OpenWeatherService: WeatherService {
    private let apiKey: String
    
    private let repository: WeatherRepository
    init(repository: WeatherRepository) {
        self.repository = repository
        self.apiKey = Strings.apiKey
    }

    func fetchWeather(for city: String) async throws -> WeatherDTO {
        try await repository.fetchCurrent(city: city, apiKey: apiKey)
    }

    func fetchForecast(for city: String) async throws -> ForecastDTO {
        try await repository.fetchForecast(city: city, apiKey: apiKey)
    }
    
    func fetchHourlyForecast(for city: String) async throws -> ForecastDTO {
        // For OpenWeather 2.5, hourly is usually part of onecall or just use forecast
        try await repository.fetchForecast(city: city, apiKey: apiKey)
    }
}

