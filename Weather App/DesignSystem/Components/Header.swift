//
//  Header.swift
//  Weather App
//
//  Created by Nadira Seitkazy  on 09.02.2026.
//
import SwiftUI

struct HeaderView: View {

    let city: String
    let date: String
    let icon: String
    let temperature: String
    let description: String

    var body: some View {
        VStack(spacing: 8) {
            Text(city)
                .font(FontTheme.title())

            Text(date)
                .font(FontTheme.desc())
                .foregroundColor(ColorTheme.desc)

            Image(systemName: icon)
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(ColorTheme.primary)

            Text(temperature)
                .font(FontTheme.largeTemperature())

            Text(description)
                .font(FontTheme.body())
                .foregroundColor(ColorTheme.desc)
        }
    }
}
