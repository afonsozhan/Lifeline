import SwiftUI

struct SettingsView: View {
    @Binding var PhoneNumber: String
    @Binding var Message: String
    
    var body: some View {
        VStack {
            Text("Emergency contact number:")
                .frame(maxWidth: .infinity, alignment: .center)
            TextField("Enter phone number here", text: $PhoneNumber)
                .multilineTextAlignment(.center)
            Text("Customizable message:")
                .frame(maxWidth: .infinity, alignment: .center)
            TextField("Having a serious emergency, need help urgently.", text: $Message)
                .multilineTextAlignment(.center)
            Image("tos").resizable().frame(width: screenWidth * 0.85, height: screenWidth * 0.85).position(x: screenWidth * 0.5, y: screenHeight * 0.3)
        }
    }
    

    
}
