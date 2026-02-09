//
//  DetailWeatherView.swift
//  Weather App
//
//  Created by Nadira Seitkazy on 09.02.2026.
//

import SwiftUI

struct DetailWeatherView: View {
    @ObservedObject var model: DetailWeatherViewModel
    @ObservedObject var router: AppRouter

    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                
                HStack {
                    Button {
                        router.route = .home
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(FontTheme.body())
                            .foregroundColor(ColorTheme.primary)
                            .padding(12)
                            .background(ColorTheme.card)
                            .clipShape(Circle())
                            .shadow(color: ColorTheme.foreground.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top)

                // Main Weather Card
                VStack(spacing: 24) {
                    VStack(spacing: 8) {
                        Text(model.currentWeather?.city ?? "--")
                            .font(FontTheme.title())
                            .foregroundColor(ColorTheme.input)
                        
                        Text(model.formattedDate)
                            .font(FontTheme.desc())
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(ColorTheme.input.opacity(0.2))
                            .foregroundColor(ColorTheme.input)
                            .clipShape(Capsule())
                    }

                    if let weather = model.currentWeather {
                        VStack(spacing: 8) {
                            Image(systemName: weather.weatherIcon)
                                .renderingMode(.original)
                                .font(FontTheme.largeTemperature())
                                .foregroundColor(ColorTheme.input)
                            
                            Text(weather.temperature)
                                .font(FontTheme.largeTemperature())
                                .foregroundColor(ColorTheme.input)
                            
                            Text(weather.condition)
                                .font(FontTheme.title(weight: .medium))
                                .foregroundColor(ColorTheme.input.opacity(0.8))
                        }
                    }

                    VStack(alignment: .leading, spacing: 16) {
                        Text("Hourly Forecast")
                            .font(FontTheme.title(weight: .semibold))
                            .foregroundColor(ColorTheme.input)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(model.hourly) { hour in
                                    HourlyCell(hour: hour)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.bottom, 16)
                }
                .padding(.vertical, 24)
                .background(
                    LinearGradient(
                        colors: [ColorTheme.primary, ColorTheme.orange],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(30)
                .padding(.horizontal)
                .shadow(color: ColorTheme.primary.opacity(0.3), radius: 10, x: 0, y: 5)

                VStack(alignment: .leading, spacing: 16) {
                    Text(Strings.info)
                        .font(FontTheme.title(weight: .semibold))
                        .foregroundColor(ColorTheme.primary)
                        .padding(.horizontal)
                    
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(model.info) { item in
                            InfoItemView(item: item)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.bottom, 32)
        }
        .background(ColorTheme.background.ignoresSafeArea())
    }
}
