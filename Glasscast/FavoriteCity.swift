//
//  FavoriteCity.swift
//  Glasscast
//
//  Created by Surya Sai Gopalam on 17/01/26.
//


import Foundation

struct FavoriteCity: Codable, Identifiable,Hashable {
    let id: String
    let user_id: String
    let city_name: String
    let lat: Double
    let lon: Double
    let created_at: String
}
