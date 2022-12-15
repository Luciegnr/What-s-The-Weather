//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Anaïs Puig on 20/09/2022.
//

import Foundation
struct WeatherData: Codable {
    struct Current: Codable {
        struct Weather: Codable {
            let id: Int
            let main: String
            let description: String
            let icon: String
        }
        let dt: Double
        let sunrise: Double
        let sunset: Double
        let temp: Double
        let feels_like: Double
        let pressure: Int
        let humidity: Int
        let dew_point: Double
        let uvi: Double
        let clouds: Int
        let visibility: Int
        let wind_speed: Double
        let wind_deg: Double
        let weather: [Weather]

        private enum Codingkeys: String, CodingKey {
            case dt
            case sunrise
            case sunset
            case temp
            case feels_like
            case pressure
            case humidity
            case dew_point
            case uvi
            case clouds
            case visibility
            case wind_speed
            case wind_deg
            case weather
        }
    }
    struct Hourly: Codable {
        struct Weather: Codable {
            let id: Int
            let main: String
            let description: String
            let icon: String
        }
        let dt: Double
        let temp: Double
        let feels_like: Double
        let pressure: Int
        let humidity: Int
        let dew_point: Double
        let uvi: Double
        let clouds: Int
        let visibility: Int
        let wind_speed: Double
        let wind_deg: Double
        let weather: [Weather]
        let pop: Double

        private enum Codingkeys: String, CodingKey {
            case dt
            case temp
            case feels_like
            case pressure
            case humidity
            case dew_point
            case uvi
            case clouds
            case visibility
            case wind_speed
            case wind_deg
            case weather
            case pop
        }
    }
    struct Daily: Codable {
        struct Temp: Codable {
            let day: Double
            let min: Double
            let max: Double
            let night: Double
            let eve: Double
            let morn: Double
        }
        struct FeelsLike: Codable {
            let day: Double
            let night: Double
            let eve: Double
            let morn: Double
        }
        struct Weather: Codable {
            let id: Int
            let main: String
            let description: String
            let icon: String
        }
        let dt: Double
        let sunrise: Double
        let sunset: Double
        let temp: Temp
        let feels_like: FeelsLike
        let pressure: Int
        let humidity: Int
        let dew_point: Double
        let wind_speed: Double
        let wind_deg: Double
        let weather: [Weather]
        let clouds: Int
        let pop: Double
        let uvi: Double
        let rain: Double?

        private enum CodingKeys: String, CodingKey {
            case dt
            case sunrise
            case sunset
            case temp
            case feels_like = "feels_like"
            case pressure
            case humidity
            case dew_point
            case wind_speed
            case wind_deg
            case weather
            case clouds
            case pop
            case uvi
            case rain
        }
    }
    let lat: Double
    let lon: Double
    let timezone: String
    let timezoneOffset: Int
    let current: Current
    let hourly: [Hourly]
    let daily: [Daily]

    private enum CodingKeys: String, CodingKey {
        case lat
        case lon
        case timezone
        case timezoneOffset = "timezone_offset"
        case current
        case hourly
        case daily
    }
}
    
