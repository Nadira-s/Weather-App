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
    
    private let network: NetworkManager
    
    init(network: NetworkManager = NetworkManager()) {
            self.network = network
        }

    func fetchWeather(for city: String) async throws -> WeatherDTO {
          try await network.request(
              endpoint: WeatherEndpoint.current(city: city).urlRequest
          )
      }

    func fetchForecast(for city: String) async throws -> ForecastDTO {
           try await network.request(
               endpoint: WeatherEndpoint.forecast(city: city).urlRequest
           )
       }
    
    func fetchHourlyForecast(for city: String) async throws -> ForecastDTO {
            try await network.request(
                endpoint: WeatherEndpoint.forecast(city: city).urlRequest
            )
        }

}
