//
//  SupabaseManager.swift
//  Glasscast
//
//  Created by Surya Sai Gopalam on 17/01/26.
//

import Supabase
import Foundation



final class SupabaseManager {

    static let shared = SupabaseManager()

    let client: SupabaseClient
    
    let apiConfig = APIConfig.getApiConfig

    private init?() {
   
        guard let supabaseKey = apiConfig?.supabaseKey, let supabaseURL = apiConfig?.supabaseURL else {
            return nil
        }
        
        client = SupabaseClient(
            supabaseURL: URL(string: supabaseURL)!,
            supabaseKey: supabaseKey
        )
    }
}

extension SupabaseManager {

    func signUp(email: String, password: String) async throws {
        try await client.auth.signUp(
            email: email,
            password: password
        )
    }

    func signIn(email: String, password: String) async throws {
        try await client.auth.signIn(
            email: email,
            password: password
        )
    }

    func signOut() async throws {
        try await client.auth.signOut()
    }

    func currentUser() async -> User? {
        try? await client.auth.session.user
    }
}





extension SupabaseManager {

    func fetchFavoriteCities() async throws -> [FavoriteCity] {

        let response = try await client.database
            .from("favorite_cities")
            .select()
            .order("created_at", ascending: false)
            .execute()

        return try JSONDecoder().decode(
            [FavoriteCity].self,
            from: response.data
        )
//        print(String(data: response.data, encoding: .utf8) ?? "Failed in data")
//        return []
    }

    func addFavoriteCity(
        name: String,
        lat: Double,
        lon: Double
    ) async throws {

        let session = try await client.auth.session
        let user = session.user

        let insert = FavoriteCityInsert(
            user_id: user.id,
            city_name: name,
            lat: lat,
            lon: lon
        )

        try await client.database
            .from("favorite_cities")
            .insert(insert)
            .execute()
    }
    func deleteFavoriteCity(id: String) async throws {

        try await client.database
            .from("favorite_cities")
            .delete()
            .eq("id", value: id)
            .execute()
    }
}

