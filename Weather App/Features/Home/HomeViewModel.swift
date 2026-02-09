//
//  HomeViewModel.swift
//  Weather App
//
//  Created by Nadira Seitkazy  on 02.02.2026.
//
import Foundation


@MainActor
final class HomeViewModel: ObservableObject {

    @Published var city: String = ""
    @Published private(set) var state: HomeViewState = .idle
    @Published var forecast: [ForecastDay] = []
    
    @Published var cityName = ""
    @Published var temperature = "--"
    @Published var condition = ""
    @Published var humidity = "--"
    @Published var windSpeed = "--"
    @Published var weatherIcon = "cloud"

    private let service: WeatherService

    init(service: WeatherService) {
        self.service = service
    }

    func search() async {
        guard !city.isEmpty else { return }

        state = .loading

        do {
            async let weather = service.fetchWeather(for: city)
            async let forecast = service.fetchForecast(for: city)

            let weatherResponse = try await weather
            let forecastResponse = try await forecast

            cityName = weatherResponse.city
            temperature = weatherResponse.temperature
            condition = weatherResponse.condition
            humidity = weatherResponse.humidity
            windSpeed = weatherResponse.windSpeed
            weatherIcon = weatherResponse.weatherIcon
            self.forecast = forecastResponse

            state = .success
        } catch {
            state = .error(Strings.error)
        }
    }

}
