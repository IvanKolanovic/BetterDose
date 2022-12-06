
import SwiftUI
import Firebase

struct LoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var loginAlert: Bool = false
    @State var fieldAlert: Bool = false
    @Binding var userAuth: Bool;
    @Binding var currentNavTab: Navigation;
    @ObservedObject var dataManager: FirestoreDataManager
    
    var body: some View{
        NavigationStack{
            VStack{
                Image("betterDose")
                Text("SIGN IN").font(.title).padding(.top,30)
                VStack{
                    CustomTextField(placeHolder: "Email", value: $email, lineColor: .black, width: 2).padding(.bottom,20)
                    CustomTextField(placeHolder: "Password",value: $password, isSecured: true, lineColor: .black, width: 2).padding(.bottom,20)
                }.onSubmit {
                    login()
                }
                Text("Don't have an account?").font(.subheadline)
                NavigationLink(destination: RegisterView(dataManager: dataManager)) {
                    Text("Sign up").font(.subheadline).foregroundColor(Color("betterRed"))
                }
            }.onAppear{
                Auth.auth().addStateDidChangeListener{auth,user in
                    if user != nil{
                        userAuth.toggle()
                    }
                }
            }.alert("Invalid", isPresented: $fieldAlert, actions: {
                Button("Okey", role: .cancel, action: {})
            },message: {Text("Both fields must be valid and not empty.")})
            .alert("Invalid", isPresented: $loginAlert, actions: {
                Button("Okey", role: .cancel, action: {})
            },message: {Text("Email or password is incorrect.")})
        }
    }
    
    func login(){
        if email.isEmpty || password.isEmpty{
            fieldAlert = true
            return
        }
        
        if !isValidEmailAddr(strToValidate: email){
            loginAlert = true
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password){
            result, error in
            if error != nil {
                loginAlert = true
                return
            }
            else{
                userAuth.toggle()
            }
        }
    }
    
    func isValidEmailAddr(strToValidate: String) -> Bool {
        let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
        return emailValidationPredicate.evaluate(with: strToValidate)
    }
}

