//
//  ContentView.swift
//  Weather App Swift UI
//
//  Created by umer on 30/08/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack{
            if let location = locationManager.location {
                if let weather = weather {
                    WeatherView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do{
                                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            } catch {
                                print("Error getting weather: \(error)")
                            }
                        }
                }
                
            } else if locationManager.isLoading {
                LoadingView()
                
            } else {
                WelcomeView()
                    .environmentObject(locationManager)
            }
            
        }
        .background(Color(hue: 0.708, saturation: 0.877, brightness: 0.466))
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
