//
//  WeatherService.swift
//  Weather App
//
//  Created by Nadira Seitkazy on 03.02.2026.
//
import Foundation

protocol WeatherService {
    func fetchWeather(for city: String) async throws -> WeatherResponse
    func fetchForecast(for city: String) async throws -> [ForecastDay]
    func fetchHourlyForecast(for city: String) async throws -> [HourlyForecast]
}

final class OpenWeatherService: WeatherService {

    private let apiKey = Strings.apiKey

    // Текущая погода
    func fetchWeather(for city: String) async throws -> WeatherResponse {

        let cityTrimmed = city.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cityTrimmed.isEmpty else { throw URLError(.badURL) }

        let cityEncoded = cityTrimmed.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? cityTrimmed
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityEncoded)&units=metric&appid=\(apiKey)"
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }

        let (data, response) = try await URLSession.shared.data(from: url)
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 404 {
            throw NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: Strings.error])
        }

        let dto = try JSONDecoder().decode(WeatherDTO.self, from: data)

        return WeatherResponse(
            city: dto.name,
            temperature: "\(Int(dto.main.temp))°",
            condition: dto.weather.first?.main ?? "-",
            humidity: "\(dto.main.humidity)%",
            weatherIcon: mapIcon(dto.weather.first?.main),
            windSpeed: "\(Int(dto.wind.speed)) m/s",
            forecast: []
        )
    }

    func fetchForecast(for city: String) async throws -> [ForecastDay] {

        let cityTrimmed = city.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cityTrimmed.isEmpty else { throw URLError(.badURL) }

        let cityEncoded = cityTrimmed.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? cityTrimmed
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(cityEncoded)&units=metric&appid=\(apiKey)"
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }

        let (data, response) = try await URLSession.shared.data(from: url)
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 404 {
            throw NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: Strings.error])
        }

        let dto = try JSONDecoder().decode(ForecastDTO.self, from: data)

        // 1️⃣ Группируем прогноз по дням
        var grouped: [String: [ForecastDTO.Item]] = [:]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Strings.dateFormat3

        for item in dto.list {
            let date = Date(timeIntervalSince1970: item.dt)
            let key = dateFormatter.string(from: date)
            grouped[key, default: []].append(item)
        }

       
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat =  Strings.dateFormat4
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = Strings.year

        
        var forecastDays: [ForecastDay] = []

        for (key, items) in grouped {
            let temps = items.map { $0.main.temp }
            let winds = items.map { $0.wind.speed }
            let humidities = items.map { $0.main.humidity }
            let weatherConditions = items.compactMap { $0.weather.first?.main }

            let avgTemp = Int(temps.reduce(0,+) / Double(temps.count))
            let avgWind = Int(winds.reduce(0,+) / Double(winds.count))
            let avgHumidity = Int(humidities.map { Double($0) }.reduce(0, +) / Double(humidities.count))
            let condition = weatherConditions.first ?? "-"

            let date = dateFormatter.date(from: key) ?? Date()

            let dayForecast = ForecastDay(
                city: cityTrimmed,
                date: displayFormatter.string(from: date),
                day: dayFormatter.string(from: date),
                temperature: "\(avgTemp)°",
                condition: condition,
                icon: mapIcon(condition),
                wind: "\(avgWind) m/s",
                humidity: "\(avgHumidity)%"
            )

            forecastDays.append(dayForecast)
        }

        // 4️⃣ Сортируем по дате
        forecastDays.sort { $0.date < $1.date }

        return forecastDays
    }
    func fetchHourlyForecast(for city: String) async throws -> [HourlyForecast] {

        let cityTrimmed = city.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cityTrimmed.isEmpty else { throw URLError(.badURL) }

        let cityEncoded = cityTrimmed.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? cityTrimmed
        let urlString =
        "https://api.openweathermap.org/data/2.5/forecast?q=\(cityEncoded)&units=metric&appid=\(apiKey)"

        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let dto = try JSONDecoder().decode(ForecastDTO.self, from: data)

        let formatter = DateFormatter()
        formatter.dateFormat = Strings.date
        let dateString = formatter.string(from: Date())

        return dto.list.prefix(3).map { item in
            HourlyForecast(
                time: formatter.string(from: Date(timeIntervalSince1970: item.dt)),
                temperature: Int(Double(item.main.temp) ?? 0),
                icon: mapIcon(item.weather.first?.main)
            )
        }
    }


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
