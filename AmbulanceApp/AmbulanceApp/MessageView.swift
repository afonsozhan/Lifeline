//
//  MessageView.swift
//  AmbulanceApp
//
//  Created by Brandon Zhou on 10/23/21.
//

import SwiftUI

struct MessageView: View {
    @Binding var PhoneNumber: String
    @Binding var Message: String
    @Binding var fullAddress: String
    
    var body: some View {
        
        VStack{
                Text("Recipient:").font(.title2).position(x: screenWidth * 0.5, y: 0)
    Text("\(PhoneNumber)").font(.title2).position(x: screenWidth * 0.5, y: screenHeight * 0.02)

                Text("Message:").font(.title2).position(x: screenWidth * 0.5, y: screenHeight * 0.1)
    Text("\(Message)").frame(width: screenWidth * 0.8, height: screenHeight * 0.2).position(x: screenWidth * 0.5, y: screenHeight * 0.13).multilineTextAlignment(.center)
        }
        
        Button(action: {
            sendMessage()
        }, label: {
            Text("Send Message").font(.title).foregroundColor(Color.blue).padding(.bottom, screenWidth * 0.5)
            }).position(x: screenWidth * 0.5, y: screenHeight * 0.4)
    }
    
    func callAmb(){
        let sms: String = "tel://14047722532)"
        let strURL = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
    }
    
    func sendMessage(){
            let sms: String = "sms:\(PhoneNumber)&body=\(Message) -location here: \(fullAddress)"
            let strURL = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
        }
}
