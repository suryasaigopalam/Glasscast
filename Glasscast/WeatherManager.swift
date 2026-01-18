//
//  WeatherManager.swift
//  Glasscast
//
//  Created by Surya Sai Gopalam on 17/01/26.
//

import Foundation
@Observable
class WeatherManager {
    
    
    func getWeather(city:String,system:System) async throws -> WeatherObject {
        
        let URLString = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=b6a17e9857279ebe7c7dd6c1053de423&units=\(system.rawValue)"
        guard let url = URL(string: URLString) else {
            throw URLError(.badServerResponse)
        }
        print(url.absoluteString)
        
             let(data,_) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            return try decoder.decode(WeatherObject.self, from: data)
                
            
      
        
    }
    
    
}
