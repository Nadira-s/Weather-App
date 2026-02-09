//
//  CurrentWeatherCard.swift
//  Weather App
//
//  Created by Nadira Seitkazy  on 05.02.2026.
//
import SwiftUI

struct WeatherCardView: View {

    let city: String
    let temperature: String
    let condition: String
    let icon: String
    let wind: String
    let humidity: String

    var body: some View {
        VStack(spacing: 24) {

            Text(city)
                .font(.title)
                .foregroundColor(ColorTheme.input)

            Image(systemName: icon)
                .font(FontTheme.largeTemperature())
                .foregroundColor(ColorTheme.input)

            Text("\(temperature)")
                .font(FontTheme.title())
                .foregroundColor(ColorTheme.input)

            Text(condition)
                .foregroundColor(ColorTheme.input)

            HStack {
                if !wind.isEmpty {
                    WeatherStatItem(title: "Wind", value: wind)
                }
                if !humidity.isEmpty {
                    WeatherStatItem(title: "Humidity", value: humidity)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                colors: [ColorTheme.primary,ColorTheme.orange],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(28)
    }
}

extension WeatherCardView {
    init(forecast: ForecastDay) {
        self.city = forecast.day
        self.temperature = forecast.temperature
        self.condition = forecast.condition
        self.icon = forecast.icon
        self.wind = forecast.wind
        self.humidity = forecast.humidity
    }

    init(hourly: HourlyForecast) {
        self.city = hourly.time
        self.temperature = "\(hourly.temperature)°"
        self.condition = ""
        self.icon = hourly.icon
        self.wind = ""
        self.humidity = ""
    }
}
