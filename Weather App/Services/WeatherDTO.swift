import Foundation

struct WeatherDTO: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind

    struct Main: Codable {
        let temp: Double
        let humidity: Int
    }

    struct Weather: Codable {
        let main: String
    }

    struct Wind: Codable {
        let speed: Double
    }
}
