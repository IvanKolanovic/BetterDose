
import SwiftUI
import Firebase

struct EditNameView: View {
    
    @State var fullName: String = ""
    @State var showAlert:Bool = false
    @ObservedObject var dataManager: FirestoreDataManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View{
        VStack{
            Image("betterDose")
            Text("Change full name").font(.title).padding(.top,30)
            CustomTextField(placeHolder: "Full name", value: $fullName, lineColor: .black, width: 2).padding(.bottom,20).padding(.bottom,20)
            Button {
                updateName()
            } label: {
                Text("Update full name")
                    .frame(maxWidth: 300,maxHeight: 50)
            }.buttonStyle(.borderedProminent).tint(Color("betterRed")).padding(.top,30)
        }.alert("Invalid", isPresented: $showAlert, actions: {
            Button("Okey", role: .cancel, action: {})
        },message: {Text("The field must be valid and not empty.")})
    }
    
    func updateName() {
        if fullName.isEmpty{
            showAlert = true
            return
        }
        dataManager.updateName(fullName)
        self.presentationMode.wrappedValue.dismiss()
    }
}


