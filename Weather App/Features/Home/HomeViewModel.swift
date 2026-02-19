//
//  HomeViewModel.swift
//  Weather App
//
//  Created by Nadira Seitkazy  on 02.02.2026.
//
//
//  HomeViewModel.swift
//  Weather App
//
import Foundation

@MainActor
final class HomeViewModel: ObservableObject {

    @Published var city: String = ""
    @Published private(set) var state: HomeViewState = .idle
    @Published var forecast: [ForecastDay] = []
    @Published var hourly: [HourlyForecast] = []
    @Published var currentWeatherCardViewModel: WeatherCardViewModel?

    private let service: WeatherService

    init(service: WeatherService) {
        self.service = service
    }

    func search() async {
        guard !city.isEmpty else { return }

        state = .loading

        do {
            async let weatherDTO = service.fetchWeather(for: city)
            async let forecastDTO = service.fetchForecast(for: city)
            async let hourlyDTO = service.fetchHourlyForecast(for: city)

            let weather = try await weatherDTO
            let forecast = try await forecastDTO
            let hourly = try await hourlyDTO

            self.currentWeatherCardViewModel = WeatherCardViewModel(from: weather)
            self.forecast = ForecastDay.from(forecast, city: city)
            self.hourly = HourlyForecast.from(hourly)

            state = .success
        } catch {
            state = .error(Strings.error)
        }
    }

  
    var cityName: String { currentWeatherCardViewModel?.title ?? "" }
    var temperature: String { currentWeatherCardViewModel?.temperature ?? "" }
    var condition: String { currentWeatherCardViewModel?.condition ?? "" }
    var weatherIcon: String { currentWeatherCardViewModel?.icon ?? "" }
    var windSpeed: String { currentWeatherCardViewModel?.wind ?? "" }
    var humidity: String { currentWeatherCardViewModel?.humidity ?? "" }

   
    private func mapIcon(_ condition: String?) -> String {
        switch condition {
        case Strings.Condition.clear: return "sun.max.fill"
        case Strings.Condition.clouds: return "cloud.fill"
        case Strings.Condition.rain: return "cloud.rain.fill"
        case Strings.Condition.snow: return "snow"
        case Strings.Condition.thunderstorm: return "cloud.bolt.fill"
        default: return Strings.Condition.clouds
        }
    }
}
