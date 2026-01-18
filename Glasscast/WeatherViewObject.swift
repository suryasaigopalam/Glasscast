//
//  WeatherViewObject.swift
//  Glasscast
//
//  Created by Surya Sai Gopalam on 17/01/26.
//

import Foundation

struct WeatherViewObject {
    let city:String
    let humidity: Int
    let temperature:Double
    let date:String
    let description:String
    let feels_like:Double
    let windSpeed:Double
    let system:System
}
extension WeatherViewObject {

    func sfSymbolName() -> String {
        let desc = description.lowercased()

        switch desc {

        case "clear sky":
            return "sun.max"

        case "few clouds":
            return "cloud.sun"

        case "scattered clouds":
            return "cloud"

        case "broken clouds", "overcast clouds":
            return "cloud.fill"

        case "shower rain":
            return "cloud.drizzle"

        case "rain":
            return "cloud.rain"

        case "thunderstorm":
            return "cloud.bolt.rain"

        case "snow":
            return "snow"

        case "mist", "fog", "haze":
            return "cloud.fog"

        default:
            return "questionmark.circle"
        }
    }
}

extension WeatherViewObject {

    static let preview = WeatherViewObject(city: "Guntur", humidity: 12, temperature: 33, date: "2026-01-18 06:00:00", description: "clear sky", feels_like: 29.0, windSpeed: 1.3, system: .metric)
}
