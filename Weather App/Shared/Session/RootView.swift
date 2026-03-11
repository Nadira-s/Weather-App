//
//  RootView.swift
//  Weather App
//
//  Created by Nadira Seitkazy  on 05.02.2026.
//
import SwiftUI

struct RootView: View {
    let dependencies: AppDependencies
    @StateObject private var router = AppRouter()
    
    var body: some View {
        switch router.route {
        case .splash:
            SplashScreenView(router: router)
        case .home:
            HomeView(router: router, service: dependencies.weatherService)
        case .detail(let model):
            DetailWeatherView(model: model, router: router)
        }
    }
}
