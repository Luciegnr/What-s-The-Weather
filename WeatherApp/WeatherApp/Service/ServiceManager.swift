//
//  ServiceManager.swift
//  WeatherApp
//
//  Created by Anaïs Puig on 20/09/2022.
//

import Foundation
import Combine
struct ServiceManager {
    
    static func getWeatherData(lat: String, long: String, units: String = "metric") -> AnyPublisher<WeatherData, Error> {
        let url = URL (string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(long)&units=\(units)&lang=fr&appid=1c2ba745810db56a9f945361a2520a0a")!
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
                
            }
            .decode(type: WeatherData.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    
    static func loadCity(lat: String, long: String) -> AnyPublisher<[CityName], Error> {
        
        let url = URL(
            string:
                "https://api.openweathermap.org/geo/1.0/reverse?lat=\(lat)&lon=\(long)&limit=5&appid=1c2ba745810db56a9f945361a2520a0a"
        )!
        return URLSession.shared.dataTaskPublisher(for: url).tryMap { element -> Data in
            guard let httpResponse = element.response as? HTTPURLResponse,
                  httpResponse.statusCode == 200
            else {
                throw URLError(.badServerResponse)
            }
            
            return element.data
            
        }
        .decode(type: [CityName].self, decoder: JSONDecoder()).eraseToAnyPublisher()
    }
}
