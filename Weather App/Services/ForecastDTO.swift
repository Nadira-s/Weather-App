import Foundation

struct ForecastDTO: Codable {
    let list: [Item]

    struct Item: Codable {
        let dt: TimeInterval
        let main: WeatherDTO.Main
        let weather: [WeatherDTO.Weather]
        let wind: WeatherDTO.Wind
    }
}
