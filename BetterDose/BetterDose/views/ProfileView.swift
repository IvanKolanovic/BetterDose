

import SwiftUI
import Firebase

struct ProfileView: View{
    
    @Binding var currentNav: Navigation
    @Binding var userAuth: Bool;
    @State private var presentAlert = false
    @ObservedObject var dataManager: FirestoreDataManager
    
    var body: some View{
        ZStack{
            if dataManager.isFetching{
                ProgressView("Loading...").progressViewStyle(.circular)
            }else{
                VStack{
                    Text("User information").font(.title2).fontWeight(.bold)
                    Spacer()
                    VStack{
                        Image(systemName: "person").font(.system(size: 60))
                        Text(dataManager.currentUser?.getFullName() ?? "Not found").font(.system(size: 22)).fontWeight(.bold).padding(.bottom,5)
                        Text(dataManager.currentUser?.getEmail() ?? "Not found").font(.system(size: 16)).fontWeight(.light).padding(.bottom,1)
                        Text("Member since \(dataManager.currentUser?.getCreatedAt() ?? "")").font(.system(size: 16)).fontWeight(.light)
                    }
                    Spacer()
                    NavigationLink(destination: EditNameView(dataManager: dataManager)) {
                        Text("Edit profile")
                        .frame(maxWidth: 285,maxHeight: 50)          }.buttonStyle(.borderedProminent).tint(Color("betterRed")).padding(.bottom,10)
                    NavigationLink(destination: DeleteAccView(userAuth: $userAuth, currentNav: $currentNav, dataManager: dataManager)) {
                        Text("Delete account")
                        .frame(maxWidth: 285,maxHeight: 50)          }.buttonStyle(.borderedProminent).tint(Color("betterRed")).padding(.bottom,10)
                    Button {
                        signOut()
                        
                    } label: {
                        Text("Sign out")
                            .frame(maxWidth: 285,maxHeight: 50)
                    }.buttonStyle(.borderedProminent).tint(Color("betterRed")).padding(.bottom,10)
                }
            }
        }.task {
            let a = Auth.auth().currentUser
            if a != nil {
                await  dataManager.fetchUser(a!.uid)
            }
        }
    }
    
    func signOut(){
        do { try Auth.auth().signOut()
            userAuth.toggle()
        }
        catch { print("already logged out") }
        
        if !userAuth{
            currentNav = Navigation.login
        }
    }
    
}


