//
//  ContentView.swift
//  AmbulanceApp
//
//  Created by Avi Athota on 10/23/21.
//

import SwiftUI
import MapKit
<<<<<<< HEAD

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37, longitude: 43), span:MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
    
    var body: some View {
        Map (coordinateRegion: $region, showsUserLocation: true)
=======
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
        
        VStack {
            if locationManager.location != nil {
                Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: nil).frame(width: screenWidth, height: screenWidth * 1.75).padding(.bottom, screenWidth * 0.5)
            } else {
                Text("Locating user location...")
            }
        }
        
        .onAppear {
            setCurrentLocation()
        }
>>>>>>> 3fbaf7e79f028cd3b3c13a06bf2545ed3b6c14f6
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

<<<<<<< HEAD
final class ContentViewModel: ObservableObject {
    var locationManager: CLLocationManager?
    
    func close() {
        exit(1)
    }
    
    func locationEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            
        } else {
            Alert(title: Text("Hello World!"), message: Text("An important message"))
            

            
            
            /* print("Failed to find location").alert(isPresented: showAlert) {
                    Alert(
                        title: Text("Your location is disabled!"),
                        message: Text("Please enable location services in settings to use this app."))
                    close()
                } */
        }
    }
}
=======

>>>>>>> 3fbaf7e79f028cd3b3c13a06bf2545ed3b6c14f6
