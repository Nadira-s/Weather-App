//
//  CurrentWeatherCard.swift
//  Weather App
//
//  Created by Nadira Seitkazy  on 05.02.2026.
//
import SwiftUI

struct WeatherCardView: View {

    let viewModel: WeatherCardViewModel

    var body: some View {
        VStack(spacing: 24) {

            Text(viewModel.title)
                .font(.title)
                .foregroundColor(ColorTheme.input)

            Image(systemName: viewModel.icon)
                .font(FontTheme.largeTemperature())
                .foregroundColor(ColorTheme.input)

            Text(viewModel.temperature)
                .font(FontTheme.title())
                .foregroundColor(ColorTheme.input)

            if !viewModel.condition.isEmpty {
                Text(viewModel.condition)
                    .foregroundColor(ColorTheme.input)
            }

            HStack {
                if !viewModel.wind.isEmpty {
                    WeatherStatItem(title: "Wind", value: viewModel.wind)
                }
                if !viewModel.humidity.isEmpty {
                    WeatherStatItem(title: "Humidity", value: viewModel.humidity)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                colors: [ColorTheme.primary, ColorTheme.orange],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(28)
    }
}
