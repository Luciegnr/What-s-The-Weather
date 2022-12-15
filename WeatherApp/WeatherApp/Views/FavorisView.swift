//
//  WeatheDetailsView.swift
//  WeatherApp
//
//  Created by Lucie Granier on 26/09/2022.
//

import SwiftUI

struct  FavorisView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Core.entity(), sortDescriptors: [])
    private var core: FetchedResults<Core>
    var body: some View {
        ZStack{
            if core.count > 0 {
                TabView {
                    ForEach(core, id: \.self) { favoris in
                        VStack{
                            HStack{
                                Spacer()
                                Button (role: .destructive) {
                                    withAnimation {
                                        viewContext.delete(favoris)
                                        do {
                                            try viewContext.save()
                                        } catch {
                                        }
                                    }
                                } label: {
                                    Image(systemName: "trash.fill").foregroundColor(.white)
                                } .padding(.horizontal, 25)
                                
                            }
                            WeatherView(model: WeatherViewModel(locat_lat: favoris.lat!, locat_long: favoris.long!))
                        }.background(Color("DarkBlue"))
                    }
                }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .always)).id(core.count)
            } else {
                ZStack {
                    Color("DarkBlue").ignoresSafeArea()
                    VStack{
                        Text("No favori").foregroundColor(.white)
                    }
                }.background(Color("DarkBlue"))
                
            }
        }.background(Color("DarkBlue"))
        
    }
    
}

