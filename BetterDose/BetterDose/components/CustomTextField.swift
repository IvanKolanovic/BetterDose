
import SwiftUI

struct CustomTextField: View {
    var placeHolder: String
    @Binding var value: String
    var isSecured: Bool = false
    
    var lineColor: Color
    var width: CGFloat
    
    var body: some View {
        VStack {
            if(!self.isSecured){
                TextField(self.placeHolder, text: $value)
                    .padding().padding(.leading,20)
                    .font(.title2).textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
            }
            else{
                SecureField(self.placeHolder, text: $value)
                    .padding().padding(.leading,20)
                    .font(.title2).textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
            }
            
            Rectangle().frame(height: self.width)
                .padding(.horizontal, 20).foregroundColor(self.lineColor)
        }
    }
}
