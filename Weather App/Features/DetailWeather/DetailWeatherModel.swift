
//
//  DetailWeatherViewModel.swift
//  Weather App
//
//  Created by Nadira Seitkazy  on 02.02.2026.
//
import SwiftUI

struct HourlyForecast: Identifiable {
    let id = UUID()
    let time: String
    let temperature: Int
    let icon: String
}

struct WeatherInfoItem: Identifiable {
    let id = UUID()
    let title: String
    let value: String
    let subtitle: String? = nil
    let weatherIcon: String?
}
