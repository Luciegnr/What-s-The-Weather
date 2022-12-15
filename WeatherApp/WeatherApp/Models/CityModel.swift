//
//  CityModel.swift
//  WeatherApp
//
//  Created by Anaïs Puig on 20/09/2022.
//

import Foundation


struct CityName: Codable, Identifiable {
    var id: UUID { return UUID() }
    let name: String
    let country: String
    let lat: Double
    let lon: Double
    
}

