//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Anaïs Puig on 20/09/2022.
//

import Foundation
import Combine
import SwiftUI

class WeatherViewModel: ObservableObject {
    @Published var lat: String
    @Published var long: String
    
    @Published var weatherData: WeatherData?
    @Published var cities : CityName?
    
    @AppStorage("system") var system: Int = 0
    
    func convert(_ temp: Double) -> Double {
        let celsius = temp
        if system == 0 {
            return celsius
        } else {
            return celsius * 9 / 5 + 32
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    var Name: String {
        "\(cities?.name ?? "01d")"
    }
    var Country: String {
        "\(cities?.country ?? "01d")"
    }
    var icon: String {
        "\(weatherData?.current.weather.first?.icon ?? "01d")"
    }
    var iconURL: URL {
        URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")!
    }
    var temp: Double {
        convert(weatherData?.current.temp ?? 0)
    }
    
    var temp_min: String {
        "\(convert(weatherData?.daily[0].temp.min  ?? 0))"
    }
    
    var temp_max: String {
        "\(convert(weatherData?.daily[0].temp.max  ?? 0))"
    }
    
    var description: String {
        weatherData?.current.weather.first?.description ?? ""
    }
    var feelsLike: String {
        "\(convert(weatherData?.current.feels_like ?? 0))"
    }
    var sunrise: Double {
        weatherData?.current.sunrise ?? 0
    }
    var sunset: Double {
        weatherData?.current.sunset ?? 0
    }
    var wind_speed: String {
        "\(weatherData?.current.wind_speed ?? 0)"
    }
    var wind_deg: Double {
        weatherData?.current.wind_deg ?? 0
    }
    var humidity: String {
        "\(weatherData?.current.humidity ?? 0)"
    }
    var pressure: String {
        "\(weatherData?.current.pressure ?? 0)"
    }
    
    
    init(locat_lat: String, locat_long: String) {
        
        self.lat = locat_lat
        self.long = locat_long
        City()
        load()
    }
    
    
    func load() {
        ServiceManager
            .getWeatherData(lat: lat, long: long)
            .sink { (completion) in
                switch completion {
                case .failure(let error):
                    print(error)
                    return
                case .finished: return
                }
            } receiveValue: { [weak self] (weatherData) in
                DispatchQueue.main.async {
                    self?.weatherData = weatherData
                }
            }
            .store(in: &cancellables)
    }
    func City() {
        ServiceManager.loadCity(lat: lat, long: long).sink { (completion) in
          switch completion {
          case .failure(let error):
              print(error)
              return
          case .finished: return
          }
        } receiveValue: { [weak self] (city) in
          DispatchQueue.main.async {
              self?.cities = city[0]
          }
        }
        .store(in: &cancellables)
    }
}

