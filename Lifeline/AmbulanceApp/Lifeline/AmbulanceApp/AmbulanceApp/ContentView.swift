//
//  ContentView.swift
//  AmbulanceApp
//
//  Created by Avi Athota on 10/23/21.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37, longitude: 43), span:MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
    
    var body: some View {
        Map (coordinateRegion: $region, showsUserLocation: true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

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
