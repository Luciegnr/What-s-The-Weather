//
//  addFavoris.swift
//  WeatherApp
//
//  Created by Lucie Granier on 28/09/2022.
//


import SwiftUI
import CoreLocation
import CoreData

struct addFavoris: View {
    let persistenceController = PersistenceController.shared
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Core.entity(), sortDescriptors: [])
    private var core: FetchedResults<Core>
    
    @State var name: String = ""
    @State var long: String = ""
    @State var lat: String = ""
    
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Name", text: $name)
                TextField("Lat", text: $lat)
                TextField("Long", text: $long)
                
                HStack {
                    Spacer()
                    Button("Ajouter") {
                        addProduct()
                    }
                    Spacer()
                    Button("Clear") {
                        name = ""
                        lat = ""
                        long = ""
                    }
                    
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
        }
    }
    private func addProduct() {
        
        withAnimation {
            let product = Core(context: viewContext)
            product.name = name
            product.lat = lat
            product.long = long
            
            saveContext()
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("An error occured: \(error)")
        }
    }
}

