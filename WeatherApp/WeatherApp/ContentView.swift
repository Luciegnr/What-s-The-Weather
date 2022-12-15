//
//  ContentView.swift
//  WeatherApp
//
//  Created by Anaïs Puig on 20/09/2022.
//

import SwiftUI
import CoreLocation
struct ContentView: View {
    
    @StateObject var locationViewModel = LocationViewModel()
    let persistenceController = PersistenceController.shared
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Core.entity(), sortDescriptors: [])
    private var core: FetchedResults<Core>
    
    var body: some View {
        switch locationViewModel.authorizationStatus {
        case .notDetermined:
            AnyView(RequestLocationView())
                .environmentObject(locationViewModel)
        case .denied:
            NavigationView {
                TabView {
                    SearchView()
                        .tabItem { Label("Recherche", systemImage: "magnifyingglass")
                        }
                    FavorisView()
                        .tabItem {
                            Label("Favoris", systemImage: "star.fill")
                        }
                }
            }
        case .authorizedAlways, .authorizedWhenInUse:
            if ((coordinate?.latitude) != nil) {
                NavigationView {
                    TabView {
                        
                        WeatherView(
                            model: WeatherViewModel(
                                locat_lat: String(coordinate?.latitude ?? 0),
                                locat_long: String(coordinate?.longitude ?? 0))
                        ).tabItem {
                            Label("Accueil", systemImage: "house.fill")
                        }
                        SearchView()
                            .tabItem { Label("Recherche", systemImage: "magnifyingglass")
                            }
                        FavorisView()
                            .tabItem {
                                Label("Favoris", systemImage: "star.fill")
                            }
                    }
                }
            }
            
        default:
            Text("Error on launch")
        }
        
    }
    
    var coordinate: CLLocationCoordinate2D? {
        locationViewModel.lastSeenLocation?.coordinate
        
    }
}

struct RequestLocationView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    var body: some View {
        VStack {
        }.onAppear(perform:    {
            locationViewModel.requestPermission()
        })
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

