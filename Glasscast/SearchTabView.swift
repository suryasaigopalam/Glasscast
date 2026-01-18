//
//  SearchTabView.swift
//  Glasscast
//
//  Created by Surya Sai Gopalam on 18/01/26.
//
import SwiftUI

struct SearchTabView: View {

    @Environment(ViewModel.self) var viewModel
    @Environment(\.colorScheme) private var colorScheme

    @State private var searchText = ""
    @State private var selectedCity: FavoriteCity?          // ✅ item-based navigation
    @State private var weatherViewObjects: [WeatherViewObject] = []

    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var showingFavoriteAlert = false
    @State private var favoriteAlertMessage = ""

    var body: some View {
        NavigationStack {
            List {

                // 🔍 Search
                if !searchText.isEmpty {
                    Button {
                        performSearch()
                    } label: {
                        Text("Search")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .glassEffect()
                    .listRowSeparator(.hidden)
                }

                // 🌤 Weather Result
                if viewModel.weatherStatus == .Success,
                   let first = viewModel.getWeatherViewObject().first {

                    VStack(spacing: 16) {
                        WeatherMainView(weather: first)
                        if(!contains(city: viewModel.getWeatherViewObject().first?.city ?? " ")) {
                            Button("Add to Favorites") {
                                addFavorite()
                            }
                            .padding()
                            .glassEffect()
                        }
                    }
                    .padding(.vertical, 8)
                    .listRowSeparator(.hidden)
                }

                // ⭐ Favorites Section
                Section {
                    FavoriteCitiesList(
                        cities: viewModel.favoriteCities,
                        selectedCity: $selectedCity,
                        weatherViewObjects: $weatherViewObjects
                    )
                } header: {
                    VStack {
                        Text("Favorite Cities (tap to view weather)")
                            .font(.headline)
                            .foregroundStyle(.primary)
                            .padding(.vertical, 6)
                        warningBanner
                    }
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .navigationTitle("Search")
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer,
                prompt: "Enter City name"
            )
            .onSubmit(of: .search) {
                performSearch()
            }
            .navigationDestination(item: $selectedCity) { _ in
                WeatherView(weatherObjects: weatherViewObjects)
            }
        }
        .alert("Search Result", isPresented: $showingAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(alertMessage)
        }
        .alert("Favorite Status", isPresented: $showingFavoriteAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(favoriteAlertMessage)
        }
    }

    // MARK: - Actions
    private func performSearch() {
        Task {
            do {
                try await viewModel.getCityWeather(city: searchText)
                alertMessage = "Weather data fetched successfully!"
            } catch {
                alertMessage = "Failed to fetch weather data"
            }
            showingAlert = true
        }
    }

    private func addFavorite() {
        Task {
            do {
                try await viewModel.AddFavoriteCity()
                favoriteAlertMessage = "City added to favorites successfully!"
            } catch {
                favoriteAlertMessage = "Failed to add city to favorites"
            }
            showingFavoriteAlert = true
        }
    }
    
    func contains(city:String) -> Bool {
        viewModel.favoriteCities.contains { $0.city_name == city}
    }
    
    
    private var warningBanner: some View {
        HStack(spacing: 8) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundStyle(Color.orange)

            Text("If the weather doesn’t load on first tap, tap the city again.")
                .font(.footnote)
                .foregroundStyle(.primary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Color.orange.opacity(0.15)
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
#Preview {
    SearchTabView()
        .environment(ViewModel())
}
