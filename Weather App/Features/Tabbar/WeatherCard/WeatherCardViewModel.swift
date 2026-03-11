//
//  WeatherCardViewModel.swift
//  Weather App
//
//  Created by Nadira Seitkazy on 11.02.2026.
//

import SwiftUI
import Foundation

final class WeatherCardViewModel {

    let title: String
    let temperature: String
    let condition: String
    let icon: String
    let wind: String
    let humidity: String

    init(title: String,
         temperature: String,
         condition: String,
         icon: String,
         wind: String,
         humidity: String) {
        self.title = title
        self.temperature = temperature
        self.condition = condition
        self.icon = icon
        self.wind = wind
        self.humidity = humidity
    }

    init(forecast: ForecastDay) {
        self.title = forecast.day
        self.temperature = forecast.temperature
        self.condition = forecast.condition
        self.icon = forecast.icon
        self.wind = forecast.wind
        self.humidity = forecast.humidity
    }

    init(hourly: HourlyForecast) {
        self.title = hourly.time
        self.temperature = "\(hourly.temperature)°"
        self.condition = ""
        self.icon = hourly.icon
        self.wind = ""
        self.humidity = ""
    }

    // MARK: - Convenience Initializer from DTO
    convenience init(from dto: WeatherDTO) {
        self.init(
            title: dto.name,
            temperature: "\(Int(dto.main.temp))°",
            condition: dto.weather.first?.main ?? "-",
            icon: WeatherCardViewModel.mapIcon(dto.weather.first?.main),
            wind: "\(Int(dto.wind.speed)) m/s",
            humidity: "\(dto.main.humidity)%"
        )
    }

    // MARK: - Icon Mapping
    static func mapIcon(_ condition: String?) -> String {
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

// MARK: - ForecastDay Mapping
extension ForecastDay {
    static func from(_ dto: ForecastDTO, city: String) -> [ForecastDay] {
        var grouped: [String: [ForecastDTO.Item]] = [:]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Strings.dateFormat3

        for item in dto.list {
            let date = Date(timeIntervalSince1970: item.dt)
            let key = dateFormatter.string(from: date)
            grouped[key, default: []].append(item)
        }

        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = Strings.dateFormat4
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = Strings.year

        var forecastDays: [ForecastDay] = []

        for key in grouped.keys.sorted() {
            guard let items = grouped[key] else { continue }

            let avgTemp = Int(items.map { $0.main.temp }.reduce(0,+)/Double(items.count))
            let avgWind = Int(items.map { $0.wind.speed }.reduce(0,+)/Double(items.count))
            let avgHumidity = Int(items.map { Double($0.main.humidity) }.reduce(0,+)/Double(items.count))
            let condition = items.first?.weather.first?.main ?? "-"

            let date = dateFormatter.date(from: key) ?? Date()

            forecastDays.append(ForecastDay(
                city: city,
                date: displayFormatter.string(from: date),
                day: dayFormatter.string(from: date),
                temperature: "\(avgTemp)°",
                condition: condition,
                icon: WeatherCardViewModel.mapIcon(condition),
                wind: "\(avgWind) m/s",
                humidity: "\(avgHumidity)%"
            ))
        }

        return forecastDays
    }
}

// MARK: - HourlyForecast Mapping
extension HourlyForecast {
    static func from(_ dto: ForecastDTO) -> [HourlyForecast] {
        let formatter = DateFormatter()
        formatter.dateFormat = Strings.date

        return dto.list.prefix(3).map { item in
            HourlyForecast(
                time: formatter.string(from: Date(timeIntervalSince1970: item.dt)),
                temperature: Int(item.main.temp),
                icon: WeatherCardViewModel.mapIcon(item.weather.first?.main)
            )
        }
    }
}

