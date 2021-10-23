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
    @State var NumberToMessage = ""
    @State var Message = ""
    
    var body: some View {
        Map (coordinateRegion: $region, showsUserLocation: true)
        VStack{
            TextField("Enter phone number here here", text: $NumberToMessage)
            TextField("Enter your message here", text: $Message)
        }
        Button(action: {
            sendMessage()
        }, label: {
        Text("Send Message")
        })
    }
    func sendMessage(){
        let sms: String = "sms+14046301024&body=yrugay"
        let strURL = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        //let strURL = "https://www.google.com"
        UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
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
