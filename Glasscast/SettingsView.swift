import SwiftUI

struct SettingsView: View {
    @Environment(ViewModel.self) var viewModel: ViewModel
    @State private var isCelsius: Bool = true
    
    var body: some View {
        VStack {
            Toggle(isOn: $isCelsius) {
                Text("Temperature Unit: \(isCelsius ? "Celsius" : "Fahrenheit")")
                            }
            .padding()
            .onChange(of: isCelsius) { _, newValue in
                viewModel.system = newValue ? .metric : .imperial

                if !viewModel.city.isEmpty {
                    Task {
                        try? await viewModel.getCityWeather(city: viewModel.city)
                    }
                }
            }
            .onAppear {
                isCelsius = (viewModel.system == .metric)
            }
            
            Button(action: {
                Task {
                    await viewModel.signOut()
                }
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .font(.system(size: 16, weight: .semibold))

                            Text("Log Out")
                                .font(.system(size: 16, weight: .semibold))
                               // .foregroundStyle(Color.red.gradient)
                        }
                        .foregroundStyle(Color.red.gradient)
                        .padding()
                     
                    }
                    
                    .glassEffect()
            
            
            
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsView()
        .environment(ViewModel())
}
