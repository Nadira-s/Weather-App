//
//  Weather_AppApp.swift
//  Weather App
//
//  Created by Nadira Seitkazy  on 28.01.2026.
//

import SwiftUI

final class AppDependencies {
    let apiClient: APIClient
    let weatherRepository: RemoteWeatherRepository
    let weatherService: WeatherService

    init() {
        let client = APIClient()
        self.apiClient = client
        let repo = RemoteWeatherRepository(api: client)
        self.weatherRepository = repo
        self.weatherService = OpenWeatherService(repository: repo)
    }
}

@main
struct Weather_AppApp: App {
    private let deps = AppDependencies()
    
    var body: some Scene {
        WindowGroup {
            RootView(dependencies: deps)
        }
    }
}
