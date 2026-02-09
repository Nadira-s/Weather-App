//
//  ForecastCardView.swift
//  Weather App
//
//  Created by Nadira Seitkazy  on 09.02.2026.
//
import SwiftUI

struct ForecastCardView: View {
    let day: ForecastDay

    var body: some View {
        WeatherCardView(forecast: day)
    }
}



