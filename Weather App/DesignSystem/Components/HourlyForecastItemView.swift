//
//  Untitled.swift
//  Weather App
//
//  Created by Nadira Seitkazy  on 09.02.2026.
//
import SwiftUI

struct HourlyForecastItemView: View {

    let item: HourlyForecast

    var body: some View {
        VStack(spacing: 8) {
            Text(item.time)
                .font(FontTheme.caption())
                .foregroundColor(ColorTheme.desc)

            Image(systemName: item.icon)
                .foregroundColor(ColorTheme.primary)

            Text("\(item.temperature)")
                .font(FontTheme.body(weight: .semibold))
        }
        .padding()
        .background(ColorTheme.card)
        .cornerRadius(16)
    }
}
