//
//  DailyView.swift
//  WeatherApp
//
//  Created by Lucie Granier on 26/09/2022.
//

import SwiftUI

struct DailyView: View {
    @State var date: String
    @State var icon: String
    @State var high: String
    @State var low: String
    var body: some View {
        HStack {
            Text(date)
                .font(.title3)
                .fontWeight(.semibold)
            
            Spacer()
            Image(systemName: icon)
            VStack{
                Text(high)
                    .fontWeight(.semibold)
                
                Text(low)
            }
        }    }
}

