//
//  MessageView.swift
//  AmbulanceApp
//
//  Created by Brandon Zhou on 10/23/21.
//

import SwiftUI

struct MessageView: View {
    @State var NumberToMessage = ""
    @State var Message = ""
    var body: some View {
        
        VStack{
            TextField("Enter phone number here here", text: $NumberToMessage).padding(.bottom)
            TextField("Enter your message here", text: $Message).padding(.bottom)
        }
        
        Button(action: {
            sendMessage()
        }, label: {
            Text("Send Message").padding(.bottom, screenWidth * 0.5)
        })
        
    }
    func sendMessage(){
        let sms: String = "sms:\(NumberToMessage)&body=\(Message)"
        let strURL = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
