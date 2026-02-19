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

// ForecastDay moved to WeatherModels.swift
