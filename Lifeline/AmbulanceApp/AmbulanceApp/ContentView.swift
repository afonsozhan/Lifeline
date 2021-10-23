//
//  ContentView.swift
//  AmbulanceApp
//
//  Created by Avi Athota on 10/23/21.
//

import SwiftUI
import MapKit
import Combine

let screen = UIScreen.main.bounds
let screenWidth = screen.size.width
let screenHeight = screen.size.height


struct ContentView: View {
    
    @ObservedObject private var locationManager = LocationManager()
    @State private var region = MKCoordinateRegion.defaultRegion
    @State private var cancellable: AnyCancellable?

    
    private func setCurrentLocation() {
        cancellable = locationManager.$location.sink { location in
            region = MKCoordinateRegion(center: location?.coordinate ?? CLLocationCoordinate2D(), latitudinalMeters: 500, longitudinalMeters: 500)
        }
    }
    
    
    var body: some View {
        NavigationView{
            VStack {
                if locationManager.location != nil {
                    Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: nil).frame(width: screenWidth, height: screenWidth * 1.75).padding(.bottom, screenWidth * 0.2)

                    NavigationLink(destination: MessageView()){
                    Text("Send Message")
                            .padding(.bottom, screenWidth * 0.5)
                    }
                } else {
                    Text("Locating user location...")
                }

            }
        }
        .onAppear {
            setCurrentLocation()
        }

       
    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


