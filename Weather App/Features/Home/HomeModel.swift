//
//  HomeModel.swift
//  Weather App
//
//  Created by Nadira Seitkazy  on 02.02.2026.
//
import Foundation

enum HomeViewState {
    case idle
    case loading
    case success
    case error(String)
}

struct ForecastDay: Identifiable {
    let id = UUID()
    let city: String
    let date: String
    let day: String
    let temperature: String
    let condition: String
    let icon: String
    let wind: String
    let humidity: String
}
