//
//  APIConfig.swift
//  Glasscast
//
//  Created by Surya Sai Gopalam on 17/01/26.
//

import Foundation

struct APIConfig:Codable {
    static let getApiConfig:APIConfig?  = {
        
        guard let url = Bundle.main.url(forResource: "Supabase_Credentials", withExtension: "json") else {
            return nil
        }
    
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
       
     
        guard let apiConfig = try? JSONDecoder().decode(APIConfig.self, from: data) else {
            return nil
        }
       
        return apiConfig
        
    }()
    let supabaseURL:String
    let supabaseKey:String
    
}
