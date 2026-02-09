
//
//  DetailWeatherModel.swift
//  Weather App
//
//  Created by Nadira Seitkazy  on 02.02.2026.
//

import SwiftUI

@MainActor
final class DetailWeatherViewModel: ObservableObject {

    private let service: WeatherService

    @Published var isLoading = false
    @Published var errorMessage: String?

    @Published var currentWeather: WeatherResponse?
    @Published var hourly: [HourlyForecast] = []
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = Strings.dateFormat
        return formatter.string(from: Date())
    }

    // Computed property for additional info
    var info: [WeatherInfoItem] {
        guard let weather = currentWeather else { return [] }
        return [
            WeatherInfoItem(title: Strings.InfoItem.wind, value: "\(weather.windSpeed)m/s", weatherIcon:Strings.InfoItem.wind),
            WeatherInfoItem(title: Strings.InfoItem.humidity, value: "\(weather.humidity)%", weatherIcon: Strings.InfoItem.humidity),
        ]
    }

    
    var forecast: [ForecastDay] {
        guard let cityName = currentWeather?.city else { return [] }

        let formatter = DateFormatter()
        formatter.dateFormat = Strings.dateFormat2

        return hourly.map { hour in
            
            let date = Date()
            let dateString = formatter.string(from: date)
            return ForecastDay(
                city: cityName,
                date: dateString,       
                day: hour.time,
                temperature: "\(hour.temperature)°",
                condition: "",
                icon: hour.icon,
                wind: "",
                humidity: ""
            )
        }
    }

    init(service: WeatherService = OpenWeatherService()) {
        self.service = service
    }

    func load(city: String) async {
        isLoading = true
        errorMessage = nil

        do {
            async let weather = service.fetchWeather(for: city)
            async let hourlyForecast = service.fetchHourlyForecast(for: city)

            self.currentWeather = try await weather
            self.hourly = try await hourlyForecast

        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
