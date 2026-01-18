//
//  WeatherView.swift
//  Glasscast
//
//  Created by Surya Sai Gopalam on 18/01/26.
//

import SwiftUI

struct WeatherView: View {
    let weatherObjects: [WeatherViewObject]
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {

                // MARK: - Today
                if let today = weatherObjects.first {
                    WeatherMainView(weather: today)
                }

                // MARK: - Upcoming
                if weatherObjects.count > 1 {
                    WeatherHorizontalView(
                        forecasts: Array(weatherObjects.dropFirst())
                    )
                }
            }
            .padding(.vertical)
            .padding(.horizontal)
        }
        .background(
            ZStack {
                if colorScheme == .dark {
                    // 🌙 Dark Mode — rich, deep, vibrant
                    LinearGradient(
                        colors: [
                            Color.black,
                            Color.indigo.opacity(0.7),
                            Color.blue.opacity(0.6)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                } else {
                    // ☀️ Light Mode — bright, airy, energetic
                    LinearGradient(
                        colors: [
                            Color.cyan.opacity(0.35),
                            Color.blue.opacity(0.25),
                            Color.indigo.opacity(0.20)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                }
            }
            .ignoresSafeArea()
        )
    }
}

#Preview {
    WeatherView(weatherObjects: [ WeatherViewObject(
        city: "San Francisco",
        humidity: 40,
        temperature: 22,
        date: "2026-01-18 12:00:00",
        description: "clear sky",
        feels_like: 21,
        windSpeed: 10,
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
    )])
}
