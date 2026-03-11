//
//  ForecastRowView.swift
//  Weather App
//
//  Created by Nadira Seitkazy  on 05.02.2026.
//
import SwiftUI

struct ForecastRowView: View {

    let model: ForecastDay

    var body: some View {
        HStack {
            Text(model.day)
                .font(FontTheme.body())

            Spacer()

            Image(systemName: model.icon)

            Spacer()

            Text(model.temperature)
                .font(FontTheme.body(weight: .semibold))
        }
        .padding()
        .background(ColorTheme.card)
        .cornerRadius(14)
    }
}
