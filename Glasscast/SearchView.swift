import SwiftUI

struct SearchView: View {

    @Environment(ViewModel.self) var viewModel
    @Environment(\.colorScheme) private var colorScheme

    @State private var searchText = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        ZStack {

            backgroundView

            VStack(spacing: 32) {

                headerView

                searchCard

                Spacer()
            }
            .padding(.top, 60)
        }
        .alert("Search Result", isPresented: $showingAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(alertMessage)
        }
        .onAppear {
            viewModel.city = ""
            viewModel.weatherObject = nil
            viewModel.weatherStatus = .NotFetched
        }
    }

    // MARK: - Background
    private var backgroundView: some View {
        LinearGradient(
            colors: colorScheme == .dark
                ? [Color.black, Color.gray.opacity(0.6)]
                : [Color.cyan.opacity(0.6), Color.indigo.opacity(0.6)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }

    // MARK: - Header
    private var headerView: some View {
        VStack(spacing: 6) {
            Text("Search City")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Get real-time weather updates")
                .foregroundStyle(.secondary)
        }
    }

    // MARK: - Glass Card
    private var searchCard: some View {
        VStack(spacing: 20) {

            TextField("Enter city name", text: $searchText)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .padding()
                .glassEffect()

            Button {
                Task {
                    do {
                        try await viewModel.getCityWeather(city: searchText)
                        alertMessage = "Weather data fetched successfully!"
                    } catch {
                        alertMessage = "Check your internet connection or city name."
                    }
                    showingAlert = true
                }
            } label: {
                Text("Search Weather")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundStyle(Color.blue.gradient)
            }
            .glassEffect()
            
            
            if let weather = viewModel.weatherObject {
                if let first = weather.list.first {
                    let temp: Double = first.main.temp
                    Text("\(temp, specifier: "%.1f")°")
                } else {
                    Text("No Temperature Data")
                }
            }
        }
        .padding(24)
        .glassEffect(in: RoundedRectangle(cornerRadius: 24))
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(
                    colorScheme == .dark
                        ? Color.white.opacity(0.15)
                        : Color.white.opacity(0.25),
                    lineWidth: 1
                )
        )
        .padding(.horizontal)
    }
}

#Preview {
    SearchView()
        .environment(ViewModel())
}

