//
//  ContentView.swift
//  AmbulanceApp
//
//  Created by Avi Athota on 10/23/21.
//

import SwiftUI
import MapKit
import Combine
import Contacts
import CoreLocation

let screen = UIScreen.main.bounds
let screenWidth = screen.size.width
let screenHeight = screen.size.height
var countryCode = ["United States": "911", "Canada": "911", "China": "120", "Japan": "119", "United Kingdom": "999", "South Africa": "10177", "Russia": "112", "India": "112", "Australia": "000", "Mexixo": "911", "Brazil": "1929"]

struct ContentView: View {
    
    @ObservedObject private var locationManager = LocationManager()
    @State private var region = MKCoordinateRegion.defaultRegion
    @State private var cancellable: AnyCancellable?
    
    @State private var PhoneNumber: String = ""
    @State private var Message: String = ""
    @State private var showAlert: Bool = false
    @State private var country: String = ""
    
    @State private var fullAddress: String = ""
     let ambMessage: String = "Please send urgent help"

    private func setCurrentLocation() {
        
        cancellable = locationManager.$location.sink { location in
            region = MKCoordinateRegion(center: location?.coordinate ?? CLLocationCoordinate2D(), latitudinalMeters: 500, longitudinalMeters: 500)
            let lat = location?.coordinate.latitude
            let long = location?.coordinate.longitude
            if (lat != nil) {
                getAddressFromLatLon(pdblLatitude: location!.coordinate.latitude, withLongitude: location!.coordinate.longitude)
                return
            }
            
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if locationManager.location != nil {
                    Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: nil).frame(width: screenWidth, height: screenWidth * 1.4).position(x: screenWidth * 0.5, y: screenHeight * 0.33)
                    Text(fullAddress).font(.title2).multilineTextAlignment(.center).frame(width: screenWidth * 0.8, height: screenHeight * 0.2).frame(maxWidth: .infinity, alignment: .center).position(x: screenWidth * 0.5, y: -screenHeight * 0.375)
                    HStack {
                        Image("Icon1").resizable().frame(width: 96.0, height: 96.0)
                            .overlay(NavigationLink(destination: MessageView(PhoneNumber: self.$PhoneNumber, Message: self.$Message, fullAddress: self.$fullAddress)) {
                                Text(" ").padding(.top)
                            })
                        Image("Icon2").resizable().frame(width: 96.0, height: 96.0).overlay(Button(action: {
                            messageAmb()
                        }, label: {Text(" ")}))
                        Image("Icon3").resizable().frame(width: 96.0, height: 96.0).overlay(Button(action: {
                            callAmb()
                        }, label: {Text(" ")}))
                        Image("Icon4").resizable().frame(width: 96.0, height: 96.0)
                    }
                } else {
                    Text("Locating user location...")
                }
                NavigationLink(destination: SettingsView(PhoneNumber: self.$PhoneNumber, Message:self.$Message)) {
                    Text("Settings") }
            }
        }
        .onAppear {
            setCurrentLocation()
        }
    }
    
    func callAmb(){
        let sms: String = "tel://\(countryCode[country] ?? "6969")"
        let strURL = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
    }
    
    func messageAmb(){
        let sms: String = "sms:< enter 911 here > &body=\(ambMessage) to this location: \(fullAddress)"
        let strURL = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)

    }
    
    func getAddressFromLatLon(pdblLatitude: Double, withLongitude pdblLongitude: Double) {
            var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
            let lat: Double = Double("\(pdblLatitude)")!
            let lon: Double = Double("\(pdblLongitude)")!
            let ceo: CLGeocoder = CLGeocoder()
            center.latitude = lat
            center.longitude = lon

            let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)


            ceo.reverseGeocodeLocation(loc, completionHandler:
                {(placemarks, error) in
                    if (error != nil)
                    {
                        print("reverse geocode fail: \(error!.localizedDescription)")
                    }
                if (placemarks != nil){
                
                    let pm = placemarks! as [CLPlacemark]

                    if pm.count > 0 {
                        let pm = placemarks![0]
                        print(pm.country)
                        print(pm.locality)
                        print(pm.subLocality)
                        print(pm.thoroughfare)
                        print(pm.postalCode)
                        print(pm.subThoroughfare)
                        var addressString : String = ""
                        if pm.subLocality != nil {
                            addressString = addressString + pm.subLocality! + ", "
                        }
                        if pm.thoroughfare != nil {
                            addressString = addressString + pm.thoroughfare! + ", "
                        }
                        if pm.locality != nil {
                            addressString = addressString + pm.locality! + ", "
                        }
                        if pm.country != nil {
                            addressString = addressString + pm.country! + ", "
                        }
                        if pm.postalCode != nil {
                            addressString = addressString + pm.postalCode! + " "
                        }
                        country = pm.country!
                        fullAddress = addressString
                  }
                }
            })
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


