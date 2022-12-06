
import SwiftUI
import Firebase

struct RegisterView: View {
    
    var dateFormatter: DateFormatter = DateFormatter()
    @State var fullName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var repeatPass: String = ""
    @State var fieldAlert: Bool = false
    @State var registerAlert: Bool = false
    @State var passAlert: Bool = false
    @State var usedAlert: Bool = false
    
    @ObservedObject var dataManager: FirestoreDataManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View{
        VStack{
            Image("betterDose")
            Text("REGISTER").font(.title).padding(.top,30)
            CustomTextField(placeHolder: "Full name", value: $fullName, lineColor: .black, width: 2).padding(.bottom,20)
            CustomTextField(placeHolder: "Email", value: $email, lineColor: .black, width: 2).padding(.bottom,20)
            CustomTextField(placeHolder: "Password",value: $password, isSecured: true, lineColor: .black, width: 2).padding(.bottom,20)
            CustomTextField(placeHolder: "Repeated password",value: $repeatPass, isSecured: true, lineColor: .black, width: 2).padding(.bottom,20)
            Button {
                register()
            } label: {
                Text("Register")
                    .frame(maxWidth: 300,maxHeight: 50)
            }.buttonStyle(.borderedProminent).tint(Color("betterRed")).padding(.top,30)
        }.alert("Invalid", isPresented: $fieldAlert, actions: {
            Button("Okey", role: .cancel, action: {})
        },message: {Text("All fields must be valid and not empty.")})
        .alert("Invalid", isPresented: $registerAlert, actions: {
            Button("Okey", role: .cancel, action: {})
        },message: {Text("Email is not valid.")}).alert("Invalid", isPresented: $passAlert, actions: {
            Button("Okey", role: .cancel, action: {})
        },message: {Text("Passwords don't match.")}).alert("Email in use", isPresented: $usedAlert, actions: {
            Button("Okey", role: .cancel, action: {})
        },message: {Text("The email is already in use.")})
        
    }
    
    func register() {
        if totalValidation(){
            Auth.auth().createUser(withEmail: email, password: password){
                result, error in
                if error != nil {
                    usedAlert = true
                    return
                }
                
                if let authResult = result{
                    dateFormatter.dateFormat = "dd-MM-YYYY HH:mm:ss"
                    let uuid = authResult.user.uid
                    let createdAt = Date()
                    let user = MyUser(id: uuid, email: email, fullName: fullName, createdAt: dateFormatter.string(from: createdAt))
                    dataManager.createUser(user)
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
    
    func isValidEmailAddr(strToValidate: String) -> Bool {
        let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
        return emailValidationPredicate.evaluate(with: strToValidate)
    }
    
    func totalValidation()-> Bool{
        if email.isEmpty || password.isEmpty || repeatPass.isEmpty{
            fieldAlert = true
            return false
        }
    
        
        if !isValidEmailAddr(strToValidate: email){
            registerAlert = true
            return false
        }
        
        if password != repeatPass{
            passAlert = true
            return false
        }
        
        return true
    }
}

