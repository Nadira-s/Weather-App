//
//  WeatherRepository.swift
//  Weather App
//
//  Created by Nadira Seitkazy on 11.03.2026.
//

import Foundation

public protocol WeatherRepository {
    func fetchCurrent(city: String, apiKey: String) async throws -> WeatherDTO
    func fetchForecast(city: String, apiKey: String) async throws -> ForecastDTO
}

public final class RemoteWeatherRepository: WeatherRepository {
    private let api: APIClientProtocol

    public init(api: APIClientProtocol) {
        self.api = api
    }

    public func fetchCurrent(city: String, apiKey: String) async throws -> WeatherDTO {
        try await api.request(APIRouter.currentWeather(city: city, apiKey: apiKey), decoder: JSONDecoder())
    }

    public func fetchForecast(city: String, apiKey: String) async throws -> ForecastDTO {
        try await api.request(APIRouter.forecast(city: city, apiKey: apiKey), decoder: JSONDecoder())
    }
}
