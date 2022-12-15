//
//  NextDaysView.swift
//  WeatherApp
//
//  Created by Lucie Granier on 26/09/2022.
//
import SwiftUI

struct NextDaysView: View {
    @State var forecasts: [WeatherData.Daily]
    let dateFormatter : DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "dd.MM."
        return f
    }()
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color("DarkBlue")
            VStack {
                Tomorrow.background(Color("LightBlue"))
                Rectangle().foregroundColor(Color("LightBlue")).frame(height: 40).cornerRadius(50, corners: [.bottomLeft, .bottomRight]).padding(.top, -20)
                Spacer()
                Divider()
                VStack{
                    Next
                } .frame(maxWidth: .infinity, alignment: .bottomTrailing)
                    .padding()
                    .padding(.top, 0)
                    .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                    .background(Color("DarkBlue"))
            }
        }
    }
    
    private var Tomorrow: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack {
                ForEach(forecasts, id: \.dt) { forecast in
                    if getTomorow(time: forecast.dt) {
                        
                        HStack{
                            Image(forecast.weather.first?.icon ?? "09nd").resizable().scaledToFit().frame(maxWidth: 165, maxHeight: 165)
                            Spacer()
                            VStack {
                                Text("Demain").foregroundColor(.white).font(.system(size: 30))
                                HStack{
                                    Text(RoudTemp(temp: "\(Convert(temp:forecast.temp.max))")).font(.system(size: 50)).foregroundColor(.white)
                                    Text("/").foregroundColor(.white).font(.system(size: 30))
                                    Text(RoudTemp(temp: "\(Convert(temp:forecast.temp.min))") + SignConvert()).font(.system(size: 40)).foregroundColor(.white)
                                }
                                Text(forecast.weather.first!.description.firstCapitalized).foregroundColor(.white)
                            }
                        }.padding(.bottom, 15)
                        HStack {
                            VStack {
                                Image(systemName: "cloud.rain").foregroundColor(.white).font(.system(size: 20))
                                Text("\(forecast.rain ?? 0)" + "%").foregroundColor(.white).font(.system(size: 20))
                                Text("Pourcentage de pluie")
                                    .font(.system(size: 12))
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }.padding(.trailing, 25)
                            
                            
                            VStack {
                                Image(systemName: "wind").foregroundColor(.white).font(.system(size: 20))
                                Text("\(forecast.wind_speed)" + " km/h").foregroundColor(.white).font(.system(size: 20))
                                Text("Vitesse du vent")
                                    .font(.system(size: 12))
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }.padding(.trailing, 25)
                            
                            VStack {
                                Image(systemName: "humidity.fill").foregroundColor(.white).font(.system(size: 20))
                                Text("\(forecast.humidity)" + "%").foregroundColor(.white).font(.system(size: 20))
                                Text("Humidité")
                                    .font(.system(size: 12))
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                
            }
        }
        .frame(maxWidth: .infinity, alignment: .bottomTrailing)
        .padding()
        .padding(.top, 0)
    }
    
    private var Next: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack {
                ForEach(forecasts, id: \.dt) { forecast in
                    if !getToday(time: forecast.dt) && !getTomorow(time: forecast.dt) {
                        HStack {
                            Text(getReadableDate(timeStamp: forecast.dt)!).foregroundColor(.white)
                            Spacer()
                            Image(forecast.weather.first?.icon ?? "09nd").resizable().scaledToFit().frame(maxWidth: 90, maxHeight: 90)
                            Text(forecast.weather.first!.description.firstCapitalized).foregroundColor(.white)
                            
                            
                            Spacer()
                            Text(RoudTemp(temp: "\(Convert(temp:forecast.temp.max))")).foregroundColor(.white).fontWeight(.bold)
                            Text("/").foregroundColor(.white)
                            Text(RoudTemp(temp: "\(Convert(temp:forecast.temp.min))") + SignConvert()).foregroundColor(.white)
                            
                        }
                    }
                }
                
            }
            
        }
        
    }
}





