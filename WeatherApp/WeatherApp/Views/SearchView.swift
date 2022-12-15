//
//  SearchView.swift
//  WeatherApp
//
//  Created by Anaïs Puig on 23/09/2022.
//

import SwiftUI
import CoreLocation

class Utils {
    static func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
    }
}

struct SearchView: View {
    
    @StateObject var completer: CityCompletion = CityCompletion()
    @State var search: String = ""
    @State var isSearching: Bool = false
    @State var isTaped: Bool = false
    @State var long: Double = 0
    @State var lat: Double = 0
    @State var cityName: String = ""
    @State private var isShowingPurple = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(completer.predictions, id: \.id) { prediction in
                    Text(prediction.description)
                        .foregroundColor(.primary)
                        .onTapGesture {
                            Utils.getCoordinateFrom(address: prediction.description) { coordinate, error in
                                if let coordinate = coordinate {
                                    lat = coordinate.latitude
                                    long = coordinate.longitude
                                    cityName = prediction.description
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        isTaped.toggle()
                                    }
                                }
                            }
                        }
                }
                
                
                NavigationLink(cityName, isActive: $isTaped) {
                    WeatherView(model: WeatherViewModel(locat_lat: String(lat), locat_long: String(long)))
                }.hidden()
            }
            .searchable(text: $search, prompt: "Cities")
            .navigationBarTitle("Search cities", displayMode: .inline)
            .onChange(of: search, perform: { newValue in
                self.isSearching = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.completer.search(self.search)
                    self.isSearching = false
                })
            })
        }
    }
}

