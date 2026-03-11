//
//  HourlyItemView.swift
//  Weather App
//
//  Created by Nadira Seitkazy  on 09.02.2026.
//
import SwiftUI

struct HourlyCell: View {

    let hour: HourlyForecast
    let viewModel: DetailWeatherViewModel

    var body: some View {
        VStack(spacing: 12) {
            Text(hour.time)
                .font(.caption)

            Image(systemName: hour.icon)
                .renderingMode(.original)

            Text("\(hour.temperature)°")
                .font(.system(size: 18, weight: .bold))
        }
        .padding()
        .frame(width: 80)
        .background(viewModel.backgroundView(for: hour))
        .cornerRadius(40)
        .shadow(
            color: ColorTheme.foreground.opacity(0.05),
            radius: 5,
            x: 0,
            y: 2
        )
    }
}
