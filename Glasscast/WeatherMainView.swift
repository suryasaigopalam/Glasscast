//
//  WeatherMainView.swift
//  Glasscast
//
//  Created by Surya Sai Gopalam on 17/01/26.
//
import SwiftUI


// MARK: - Weather Main View (Today)

struct WeatherMainView: View {
    let weather: WeatherViewObject

    var body: some View {
        VStack(spacing: 28) {

            headerSection

            weatherIcon

            temperatureSection

            statsSection
        }
        .padding()
    }
}

// MARK: - Header

extension WeatherMainView {

    private var headerSection: some View {
        VStack(spacing: 6) {
            Text(weather.city)
                .font(.title.bold())

            Text(formattedDate)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .glassEffect()
    }
}

// MARK: - Icon

extension WeatherMainView {

    private var weatherIcon: some View {
        Image(systemName: weatherSymbol)
            .font(.system(size: 88))
            .padding(24)
            .glassEffect()
    }
}

// MARK: - Temperature

extension WeatherMainView {

    private var temperatureSection: some View {
        VStack(spacing: 6) {
            Text(formattedTemperature)
                .font(.system(size: 72, weight: .light))
                .monospacedDigit()

            Text(weather.description.capitalized)
                .font(.title3)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - Stats

extension WeatherMainView {

    private var statsSection: some View {
        VStack(spacing: 16) {

            HStack(spacing: 16) {
                statItem(title: "Feels Like", value: formattedFeelsLike)
                statItem(title: "Humidity", value: "\(weather.humidity)%")
            }

            statItem(
                title: "Wind Speed",
                value: formattedWindSpeed,
                fullWidth: true
            )
        }
    }

    private func statItem(
        title: String,
        value: String,
        fullWidth: Bool = false
    ) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title.uppercased())
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(value)
                .font(.title3.bold())
        }
        .frame(maxWidth: fullWidth ? .infinity : nil, alignment: .leading)
        .padding()
        .glassEffect()
    }
}

// MARK: - Formatting & Units

extension WeatherMainView {

    private var formattedTemperature: String {
        let unit = weather.system == .metric ? "°C" : "°F"
        return "\(Int(weather.temperature))\(unit)"
    }

    private var formattedFeelsLike: String {
        let unit = weather.system == .metric ? "°C" : "°F"
        return "\(Int(weather.feels_like))\(unit)"
    }

    private var formattedWindSpeed: String {
        weather.system == .metric
        ? "\(Int(weather.windSpeed)) km/h"
        : "\(Int(weather.windSpeed)) mph"
    }

    private var formattedDate: String {
        let input = DateFormatter()
        input.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let output = DateFormatter()
        output.dateFormat = "EEEE, MMM d"

        guard let date = input.date(from: weather.date) else {
            return "—"
        }
        return output.string(from: date)
    }

    private var weatherSymbol: String {
        let desc = weather.description.lowercased()

        if desc.contains("clear") {
            return "sun.max.fill"
        } else if desc.contains("cloud") {
            return "cloud.sun.fill"
        } else if desc.contains("rain") {
            return "cloud.rain.fill"
        } else if desc.contains("snow") {
            return "snow"
        } else {
            return "cloud.fill"
        }
    }
}

// MARK: - Preview

#Preview {
    WeatherMainView(
        weather: WeatherViewObject(
            city: "San Francisco",
            humidity: 45,
            temperature: 72,
            date: "2026-01-17 18:00:00",
            description: "partly cloudy",
            feels_like: 68,
            windSpeed: 12,
            system: .imperial
        )
    )
}
