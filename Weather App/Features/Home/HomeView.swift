//
//  HomeView.swift
//  Weather App
//
//  Created by Nadira Seitkazy  on 02.02.2026.
//
import SwiftUI

struct HomeView: View {

    @ObservedObject var router: AppRouter
    @StateObject private var viewModel: HomeViewModel

    init(router: AppRouter) {
        self.router = router
        _viewModel = StateObject(
            wrappedValue: HomeViewModel(
                service: OpenWeatherService()
            )
        )
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {

          
                SearchBar(text: $viewModel.city) {
                    Task { await viewModel.search() }
                }

                content
            }
            .padding()
        }
        .background(ColorTheme.background)
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {

        case .idle:
            Text(Strings.search)
                .font(FontTheme.desc())
                .foregroundColor(ColorTheme.desc)

        case .loading:
            ProgressView()

        case .success:
            VStack(spacing: 16) {

                WeatherCardView(
                    city: viewModel.cityName,
                    temperature: viewModel.temperature,
                    condition: viewModel.condition,
                    icon: viewModel.weatherIcon,
                    wind: viewModel.windSpeed,
                    humidity: viewModel.humidity
                )

                VStack(alignment: .leading, spacing: 12) {
                    Text(Strings.dayForecast)
                        .font(FontTheme.title(weight: .semibold))

                    ForEach(viewModel.forecast) { day in
                        ForecastRowView(model: day)
                            .onTapGesture {
                                let vm = DetailWeatherViewModel()
                                Task {
                                    await vm.load(city: day.city)
                                }
                                router.route = .detail(vm)
                            }
                    }
                }
            }

        case .error(let message):
            Text(message)
                .font(FontTheme.desc())
                .foregroundColor(ColorTheme.error)
        }
    }

    private var weatherView: some View {
        WeatherCardView(
            city: viewModel.cityName,
            temperature: viewModel.temperature,
            condition: viewModel.condition,
            icon: viewModel.weatherIcon,
            wind: viewModel.windSpeed,
            humidity: viewModel.humidity
        )
    }
}
