//
//  WeatherStatItem.swift
//  Weather App
//
//  Created by Nadira Seitkazy  on 09.02.2026.
//

import SwiftUI

struct WeatherStatItem: View {

    let title: String
    let value: String

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(FontTheme.body(weight: .semibold))
                .foregroundColor(ColorTheme.input)

            Text(title)
                .font(FontTheme.caption())
                .foregroundColor(ColorTheme.input.opacity(0.8))
        }
        .frame(maxWidth: .infinity)
    }
}
