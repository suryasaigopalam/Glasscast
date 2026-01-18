//
//  FavoriteCityInsert.swift
//  Glasscast
//
//  Created by Surya Sai Gopalam on 17/01/26.
//


import Foundation

struct FavoriteCityInsert: Sendable, Encodable {
    let user_id: UUID
    let city_name: String
    let lat: Double
    let lon: Double
    
    nonisolated func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(user_id, forKey: .user_id)
        try container.encode(city_name, forKey: .city_name)
        try container.encode(lat, forKey: .lat)
        try container.encode(lon, forKey: .lon)
    }
    
    private enum CodingKeys: String, CodingKey {
        case user_id, city_name, lat, lon
    }
}
