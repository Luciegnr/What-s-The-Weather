import SwiftUI
import SDWebImageSwiftUI
import SDWebImage
import CoreLocation
import CoreData


struct WeatherView: View {
    @StateObject var model: WeatherViewModel
    @State private var checkExist: Bool?
    
    @EnvironmentObject var locationViewModel: LocationViewModel
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Core.entity(), sortDescriptors: [])
    private var core: FetchedResults<Core>
    var coordinate: CLLocationCoordinate2D? { locationViewModel.lastSeenLocation?.coordinate }
    
    var body: some View {
        ZStack {
            Color("DarkBlue")
            VStack(spacing: 8) {
                if model.weatherData != nil {
                    HStack {
                        Spacer()
                        Picker(selection: $model.system, label: Text("Picker")) {
                            Text("°C").tag(0)
                            Text("°F").tag(1)
                        }.pickerStyle(SegmentedPickerStyle()).frame(width: 100)
                        Spacer()
                        if checkExist != nil {
                            if (checkExist == false){
                                Button(action:{
                                    addFavorite()
                                    self.checkExist = true
                                }){ Image(systemName: "suit.heart.fill").foregroundColor(.white).font(.system(size: 20))}
                            }}
                    }.onAppear(perform: {
                        if model.weatherData != nil {
                            checkExist =  self.itemExists(lat: model.lat, long: model.long, name: model.Name)
                        }
                    })
                    CurrentWeather
                    boxDaily
                }}.frame(maxWidth: .infinity, alignment: .bottomTrailing).padding().padding(.top, 0).foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .bottomTrailing)
        .background(Color("DarkBlue"))
        .onAppear(perform: {
            if model.weatherData != nil {
                checkExist =  self.itemExists(lat: model.lat, long: model.long, name: model.Name)
            }
        })
    }
    
    
    
    private var CurrentWeather: some View {
        VStack {
            HStack{
                Text(model.Name).font(.system(size: 30)).foregroundColor(.white)
                Text(model.Country).font(.system(size: 20)).foregroundColor(.white)
            }
            
            VStack {
                Image(model.icon).resizable().scaledToFit().frame(maxWidth: 140, maxHeight: 140)
                Text(RoudTemp(temp: "\(model.temp)") + SignConvert())
                    .font(.system(size: 55))
                    .foregroundColor(.white)
                Text(model.description.firstCapitalized).foregroundColor(.white)
            }
            .padding(24)
            .background(RoundedRectangle(cornerRadius: 40)
                .fill(Color("LightBlue"))
            )
            HStack(spacing: 8) {
                VStack {
                    Text(RoudTemp(temp: model.temp_min) + SignConvert())
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Text("Min")
                        .font(.system(size: 12))
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                VStack {
                    Text(RoudTemp(temp: model.temp_max) + SignConvert())
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Text("Max")
                        .font(.system(size: 12))
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
            HStack(spacing: 8) {
                VStack {
                    Image(systemName: "thermometer").foregroundColor(.white).font(.system(size: 20))
                    Text(RoudTemp(temp: model.feelsLike) + SignConvert())
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Text("Ressenti")
                        .font(.system(size: 12))
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                VStack {
                    Image(systemName: "gauge.medium").foregroundColor(.white).font(.system(size: 20))
                    Text(model.pressure)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Text("Pression")
                        .font(.system(size: 12))
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                VStack {
                    Image(systemName: "humidity.fill").foregroundColor(.white).font(.system(size: 20))
                    Text(model.humidity)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Text("Humidité")
                        .font(.system(size: 12))
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                
                VStack {
                    Image(systemName: "wind").foregroundColor(.white).font(.system(size: 20))
                    Text(model.wind_speed)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Text("Vitesse du Vent")
                        .font(.system(size: 12))
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                VStack {
                    Image(systemName: "flag.fill").foregroundColor(.white).font(.system(size: 20))
                    Text("\(windDirectionFromDegrees(degrees: model.wind_deg))")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Text("Direction du Vent")
                        .font(.system(size: 12))
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
            
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 40)
                    .fill(Color("LightBlue"))
            )
            .padding(.horizontal, 25)
        }
    }
    
    private var boxDaily: some View {
        VStack(spacing: 16) {
            HStack{
                Text("Aujourd'hui").foregroundColor(.gray)
                Spacer()
                if model.weatherData != nil {
                    NavigationLink(destination: NextDaysView(forecasts: model.weatherData!.daily)) {
                        Text("Prévisions sur 7 jours").foregroundColor(.white)
                        Image(systemName: "chevron.right").foregroundColor(.white)
                    }.foregroundColor(.primary)
                }
            }.font(Font.body.bold()).padding(.horizontal, 20)
            ScrollView(.horizontal){
                HStack(spacing: 10) {
                    Spacer()
                        .frame(width: 16)
                    if model.weatherData != nil {
                        ForEach(model.weatherData!.hourly, id: \.dt) { forecast in
                            Group{
                                if (CheckCurrentDate(time: forecast.dt)) {
                                    VStack {
                                        Text("\(Getdate(time: forecast.dt))").fontWeight(.bold).foregroundColor(.white)
                                        Image(forecast.weather[0].icon)
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                        Text(RoudTemp(temp: "\(Convert(temp:forecast.temp))") + SignConvert())
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                    }
                                    .padding(24)
                                    .background(RoundedRectangle(cornerRadius: 40)
                                        .fill(Color("LightBlue"))
                                    )
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func itemExists(lat: String, long: String, name: String)-> Bool{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Core")
        fetchRequest.predicate = NSPredicate(format: "long == %@", long ,"lat == %@", lat)
        return ((try? viewContext.count(for: fetchRequest)) ?? 0) > 0
    }
    
    private func addFavorite() {
        withAnimation {
            let favorite = Core(context: viewContext)
            favorite.name = model.Name
            favorite.lat = model.lat
            favorite.long = model.long
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
    struct WeatherView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
            
        }
    }
}
