//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Anaïs Puig on 20/09/2022.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)

        }
    }
}
