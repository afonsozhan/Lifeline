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
    @State var NumberToMessage = ""
    @State var Message = ""
    
    private func setCurrentLocation() {
        cancellable = locationManager.$location.sink { location in
            region = MKCoordinateRegion(center: location?.coordinate ?? CLLocationCoordinate2D(), latitudinalMeters: 500, longitudinalMeters: 500)
        }
    }
    
    
    var body: some View {
        
        VStack {
            if locationManager.location != nil {
                Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: nil).frame(width: screenWidth, height: screenWidth * 1.75).padding(.bottom, screenWidth * 0.2)
                VStack{
                    TextField("Enter phone number here here", text: $NumberToMessage).padding(.bottom)
                    TextField("Enter your message here", text: $Message).padding(.bottom)
                }
                Button(action: {
                    sendMessage()
                }, label: {
                Text("Send Message")
                        .padding(.bottom, screenWidth * 0.5)
                })
            } else {
                Text("Locating user location...")
            }


        }
        
        .onAppear {
            setCurrentLocation()
        }

       
    }
    
    func sendMessage(){
        let sms: String = "sms+14046301024&body=hello"
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


