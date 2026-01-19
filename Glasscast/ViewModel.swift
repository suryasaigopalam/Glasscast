//
//  ViewModel.swift
//  Glasscast
//
//  Created by Surya Sai Gopalam on 18/01/26.
//

import Foundation

@Observable
class ViewModel {
    var city:String = ""
    let supaBaseManager = SupabaseManager.shared
    var weatherStatus:WeatherStatus = .NotFetched
    var weatherObject: WeatherObject? = nil
    let weatherManager = WeatherManager()
    var system = System.metric
    var authenStatus = false
    var favoriteCities:[FavoriteCity] = []

}

extension ViewModel {
    
    enum WeatherStatus {
        case NotFetched
        case Fetching
        case Success
        case Failure
    }
    
    
    
    
}


extension ViewModel {
    func Authenticate(email:String,password:String,authenMode:AuthenMode) async throws {
        guard let supaBaseManager = supaBaseManager  else {
            return
        }
        
       
        
        if authenMode == .SignIn {
            try await supaBaseManager.signIn(email: email, password: password)
            
        }
        else  {
            try await supaBaseManager.signUp(email: email, password: password)
        }
            
        self.favoriteCities =  (try? await supaBaseManager.fetchFavoriteCities()) ?? []
        
            authenStatus = true
        
        
        
    }
    
    
    func getCityWeather(city:String) async throws {
        weatherStatus = .Fetching
        do {
            let weatherData = try await weatherManager.getWeather(city: city, system: system)
            self.weatherObject = weatherData
            weatherStatus = .Success
        } catch {
            weatherStatus = .Failure
            print("Error fetching weather: \(error)")
            throw error
        }
    }
    
    private func _mapWeatherObjectToListWeatherViewObjects(weatherData: WeatherObject) -> [WeatherViewObject] {
        let city = weatherData.city.name

        return weatherData.list.map { listElement in
            return WeatherViewObject(
                city: city,
                humidity: listElement.main.humidity,
                temperature: listElement.main.temp,
                date: listElement.dt_txt,
                description: listElement.weather.first?.description ?? "",
                feels_like: listElement.main.feels_like,
                windSpeed: listElement.wind.speed,
                system: self.system
            )
        }
    }
    
    func getWeatherViewObject() -> [WeatherViewObject] {
        guard let weatherData = weatherObject else {
            return []
        }
        return _mapWeatherObjectToListWeatherViewObjects(weatherData: weatherData)
    }
    
    
    func getWeatherViewObject(city:String) async throws  -> WeatherViewObject {
        let weatherData = try await weatherManager.getWeather(city: city, system: system)
        guard let firstWeatherViewObject = _mapWeatherObjectToListWeatherViewObjects(weatherData: weatherData).first else {
            throw URLError(.badServerResponse) // Or a more specific error
        }
        return firstWeatherViewObject
    }
    
    
    func getFavortieCities() async throws  -> [FavoriteCity]? {
       return try await supaBaseManager?.fetchFavoriteCities()
        
    }
    
    func AddFavoriteCity() async  throws {
        guard let weatherData = weatherObject else {
            throw NSError(domain: "ViewModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "Weather object is nil."])
        }
        guard let supaBaseManager = supaBaseManager else {
            throw NSError(domain: "ViewModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "SupabaseManager is not initialized."])
        }
        try await supaBaseManager.addFavoriteCity(
            name: weatherData.city.name,
            lat: weatherData.city.coord.lat,
            lon: weatherData.city.coord.lon
        )
        self.favoriteCities = try (await supaBaseManager.fetchFavoriteCities()) 
    }
    
    
    func getWeatherViewObjects(city: String) async -> [WeatherViewObject] {
        do {
            let weatherData = try await weatherManager.getWeather(city: city, system: system)
            return _mapWeatherObjectToListWeatherViewObjects(weatherData: weatherData)
        } catch {
            print("Failed to fetch weather:", error)
            return []
        }
    }
    
    func signOut() async {
        weatherObject = nil
        weatherStatus = .NotFetched
        do {
            try await supaBaseManager?.signOut()
            self.authenStatus = false
        }catch {
            print(error.localizedDescription)
        }
    }
    
    
    func changeWeatherObject() async  {
        if weatherObject != nil {
            do {
                try await getCityWeather(city: weatherObject?.city.name ?? "Cupertino" )
            }catch {
                print(error.localizedDescription)
            }
            
        }
    }
    
    
}




