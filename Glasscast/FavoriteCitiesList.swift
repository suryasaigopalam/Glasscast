//
//  FavoriteCitiesList.swift
//  Glasscast
//
//  Created by Surya Sai Gopalam on 18/01/26.
//

import SwiftUI

struct FavoriteCitiesList: View {

    let cities: [FavoriteCity]

    @Environment(ViewModel.self) var viewModel
    @Binding var selectedCity: FavoriteCity?
    @Binding var weatherViewObjects: [WeatherViewObject]

    var body: some View {
        if cities.isEmpty {
            emptyStateRow
        } else {
            ForEach(cities) { city in
                Text(city.city_name)
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .glassEffect()
                    .listRowBackground(Color.clear)
                    .onTapGesture {
                        Task {
                            let result = await viewModel.getWeatherViewObjects(
                                city: city.city_name
                            )

                            await MainActor.run {
                                weatherViewObjects = result
                                selectedCity = city   // ✅ SAFE navigation trigger
                            }
                        }
                    }
            }
        }
    }

    // MARK: - Empty State Row
    private var emptyStateRow: some View {
        VStack(spacing: 12) {
            Text("No Favorite Cities")
                .font(.headline)

            Text("Add a city to see it here.")
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
        .listRowBackground(Color.clear)
    }
}

//#Preview {
//    @Previewable @State var navigationPath = NavigationPath()
//    @Previewable @State var weatherViewObjects: [WeatherViewObject] = []
//
//    FavoriteCitiesList(
//        cities: [
//            FavoriteCity(
//                id: "1",
//                user_id: "u1",
//                city_name: "Delhi",
//                lat: 28.61,
//                lon: 77.20,
//                created_at: "2026-01-18"
//            ),
//            FavoriteCity(
//                id: "2",
//                user_id: "u1",
//                city_name: "London",
//                lat: 51.50,
//                lon: -0.12,
//                created_at: "2026-01-18"
//            )
//        ],
//        
//        weatherViewObjects: $weatherViewObjects
//    )
//    .environment(ViewModel())
//}
