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
    private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37, longitude: 43), span:MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
    
    var locationManager: CLLocationManager?
    @State private var locationServices = CLLocationManager.locationServicesEnabled()
    
    func close() {
        exit(1)
    }
    
    func isLocationEnabled() {
        @State var showingAlert = false;
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            checkLocationAuthorization()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        
        } else {
            // to-do later
            close()
        }
        
    }
    
    func checkLocationAuthorization() {
        
        guard let locationManager = locationManager else {
            return
        }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        
        case .restricted:
            print("Location services restricted.")
        
        case .denied:
            print("Location services denied.")
            
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location?.coordinate,  span:MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
            break
        
        @unknown default:
            break
        }

    }
}
