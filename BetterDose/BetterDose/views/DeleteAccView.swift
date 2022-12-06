
import SwiftUI
import Firebase

struct DeleteAccView: View {
    
    @State var password: String = ""
    @State var showAlert:Bool = false
    @State var passAlert:Bool = false
    @Binding var userAuth: Bool;
    @Binding var currentNav: Navigation
    @ObservedObject var dataManager: FirestoreDataManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View{
        VStack{
            Image("betterDose")
            Text("").font(.title).padding(.top,30)
            CustomTextField(placeHolder: "Password", value: $password, isSecured: true,lineColor: .black, width: 2).padding(.bottom,20).padding(.bottom,20)
            Button {
                deleteAcc()
            } label: {
                Text("Delete account")
                    .frame(maxWidth: 300,maxHeight: 50)
            }.buttonStyle(.borderedProminent).tint(Color("betterRed")).padding(.top,30)
        }.alert("Invalid password", isPresented: $showAlert, actions: {
            Button("Okey", role: .cancel, action: {})
        },message: {Text("Password must be valid and not empty.")})
        .alert("Invalid password", isPresented: $passAlert, actions: {
            Button("Okey", role: .cancel, action: {})
        },message: {Text("Password does not match.")})
    }
    
    func deleteAcc() {
        if  password.isEmpty{
            showAlert = true
            return
        }
        
        let user = Auth.auth().currentUser
        let credential: AuthCredential = EmailAuthProvider.credential(withEmail: user!.email!, password: password)
        
        
        user?.reauthenticate(with: credential, completion: { (result, error) in
            if error != nil {
                passAlert = true
            } else {
                user?.delete { err in
                    if let err = err {
                        print(err)
                    }
                    else{
                        userAuth.toggle()
                        currentNav = Navigation.login
                    }
                }           }
        })
        
    }
}


