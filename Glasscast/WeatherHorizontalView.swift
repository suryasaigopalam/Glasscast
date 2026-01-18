//
//  WeatherHorizontalView.swift
//  Glasscast
//
//  Created by Surya Sai Gopalam on 18/01/26.
//

import SwiftUI

// MARK: - Weather Horizontal View (Upcoming Forecasts)

struct WeatherHorizontalView: View {
    let forecasts: [WeatherViewObject]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(forecasts.indices, id: \.self) { index in
                    forecastItem(forecasts[index])
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
    }
}

// MARK: - Individual Forecast Item

extension WeatherHorizontalView {

    private func forecastItem(_ weather: WeatherViewObject) -> some View {
        VStack(spacing: 10) {

            // Date (Jan 18)
            Text(formattedDate(weather.date))
                .font(.caption)
                .foregroundStyle(.secondary)

            // Weather Icon
            Image(systemName: weatherSymbol(weather.description))
                .font(.system(size: 28))

            // Temperature
            Text(formattedTemperature(weather))
                .font(.headline)
                .monospacedDigit()
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 16)
        .background(Color.clear)
        .glassEffect()
    }
}

// MARK: - Formatting Helpers

extension WeatherHorizontalView {

    private func formattedTemperature(_ weather: WeatherViewObject) -> String {
        let unit = weather.system == .metric ? "°C" : "°F"
        return "\(Int(weather.temperature))\(unit)"
    }

    /// "2026-01-18 12:00:00" → "Jan 18"
    private func formattedDate(_ dateString: String) -> String {
        let input = DateFormatter()
        input.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let output = DateFormatter()
        output.dateFormat = "MMM d"

        guard let date = input.date(from: dateString) else {
            return "—"
        }
        return output.string(from: date)
    }

    private func weatherSymbol(_ description: String) -> String {
        let desc = description.lowercased()

        if desc.contains("clear") {
            return "sun.max"
        } else if desc.contains("cloud") {
            return "cloud"
        } else if desc.contains("rain") {
            return "cloud.rain"
        } else if desc.contains("snow") {
            return "snow"
        } else {
            return "cloud"
        }
    }
}

// MARK: - Preview

#Preview {
    WeatherHorizontalView(
        forecasts: [
            WeatherViewObject(
                city: "San Francisco",
                humidity: 40,
                temperature: 22,
                date: "2026-01-18 12:00:00",
                description: "clear sky",
                feels_like: 21,
                windSpeed: 10,
                system: .imperial
            ),
            WeatherViewObject(
                city: "San Francisco",
                humidity: 50,
                temperature: 20,
                date: "2026-01-19 12:00:00",
                description: "few clouds",
                feels_like: 19,
                windSpeed: 12,
                system: .metric
            ),
            WeatherViewObject(
                city: "San Francisco",
                humidity: 60,
                temperature: 18,
                date: "2026-01-20 12:00:00",
                description: "rain",
                feels_like: 17,
                windSpeed: 16,
                system: .metric
            ),
            WeatherViewObject(
                city: "San Francisco",
                humidity: 50,
                temperature: 20,
                date: "2026-01-19 12:00:00",
                description: "few clouds",
                feels_like: 19,
                windSpeed: 12,
                system: .metric
            ),
            WeatherViewObject(
                city: "San Francisco",
                humidity: 50,
                temperature: 20,
                date: "2026-01-19 12:00:00",
                description: "few clouds",
                feels_like: 19,
                windSpeed: 12,
                system: .metric
            ),
            WeatherViewObject(
                city: "San Francisco",
                humidity: 50,
                temperature: 20,
                date: "2026-01-19 12:00:00",
                description: "few clouds",
                feels_like: 19,
                windSpeed: 12,
                system: .metric
            ),
            WeatherViewObject(
                city: "San Francisco",
                humidity: 50,
                temperature: 20,
                date: "2026-01-19 12:00:00",
                description: "few clouds",
                feels_like: 19,
                windSpeed: 12,
                system: .metric
            )
        ]
    )
}
