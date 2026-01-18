import SwiftUI

struct HomeView: View {
    @Environment(ViewModel.self) var viewModel:ViewModel
    var body: some View {
        if viewModel.weatherStatus == .Success {
            WeatherView(weatherObjects: viewModel.getWeatherViewObject())
        }
        else {
            SearchView()
        }
    }
}

#Preview {
    HomeView()
        .environment(ViewModel())
}
