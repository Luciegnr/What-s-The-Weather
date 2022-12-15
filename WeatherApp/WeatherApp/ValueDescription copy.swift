//
//  ValueDescription.swift
//  
//
//  Created by Lucie Granier on 26/09/2022.
//

import SwiftUI

struct ValueDescription: View {
    var body: some View {
        VStack {
            Image(systemName: "house")
            Text("42 %")
                .fontWeight(.bold)
            
            Text("Precipitation")
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }
}

struct ValueDescription_Previews: PreviewProvider {
    static var previews: some View {
        ValueDescription()
    }
}
