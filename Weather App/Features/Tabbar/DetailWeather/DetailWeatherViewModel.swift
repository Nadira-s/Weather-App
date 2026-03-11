
//
//  DetailWeatherViewModel.swift
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
    @Published var currentWeatherCardViewModel: WeatherCardViewModel?
    @Published var hourly: [HourlyForecast] = []
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = Strings.dateFormat
        return formatter.string(from: Date())
    }

   
    var info: [WeatherInfoItem] {
        guard let weather = currentWeather else { return [] }
        return [
            WeatherInfoItem(
                type: .uvIndex,
                title: "UV Index",
                value: "5",
                subtitle: "Moderate",
                weatherIcon: "sun.max"
            ),
            WeatherInfoItem(
                type: .wind,
                title: "Wind",
                value: "5 m/s",
                subtitle: nil,
                weatherIcon: "wind"
            ),
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

    init(service: WeatherService) {
        self.service = service
    }

    func load(city: String) async {
        isLoading = true
        errorMessage = nil

        do {
            async let weatherDTO = service.fetchWeather(for: city)
            async let hourlyDTO = service.fetchHourlyForecast(for: city)

            let weather = try await weatherDTO
            let hourly = try await hourlyDTO

            self.currentWeatherCardViewModel = WeatherCardViewModel(from: weather)
            self.hourly = HourlyForecast.from(hourly)

        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
    func backgroundView(for hour: HourlyForecast) -> AnyView {
        if hour.time == Strings.now {
            return AnyView(
                LinearGradient(
                    colors: [ColorTheme.primary, ColorTheme.orange],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .opacity(0.6)
            )
        } else {
            return AnyView(ColorTheme.border)
        }
    }
}
