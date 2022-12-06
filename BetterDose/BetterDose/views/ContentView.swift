

import SwiftUI
import Firebase

struct ContentView: View {
    @State var currentNavTab: Navigation = Navigation.login
    @State var userAuth: Bool = false;
    @ObservedObject var dataManager: FirestoreDataManager = FirestoreDataManager()
    @ObservedObject var api: ApiService = ApiService()

    var body: some View {
        if userAuth {
            renderContent
        }
        else {
            if currentNavTab == Navigation.login{
                LoginView(userAuth: $userAuth,currentNavTab: $currentNavTab, dataManager: dataManager)
            }
            else{
                RegisterView(dataManager: dataManager)
            }
        }
    }
        
    var renderContent: some View{
        TabView(selection: $currentNavTab){
            NavigationStack {
                ZStack{
                    DiaryView(dataManager: dataManager)
                }
            }
            .tabItem {
                Image(systemName: "book")
                Text("Diary")
            }
            .tag(Navigation.diary)
            
            NavigationStack {
                MyMapTab()
            }
            .tabItem {
                Image(systemName: "map")
                Text("Map")
            }.tag(Navigation.map)
            NavigationStack {
                MedView(api: api,dataManager: dataManager,currentNavTab: $currentNavTab)
            }
            .tabItem {
                Image(systemName: "text.magnifyingglass")
                Text("Search")
            }
            .tag(Navigation.search)
            NavigationStack {
                ProfileView(currentNav: $currentNavTab, userAuth: $userAuth, dataManager: dataManager)
            }
            .tabItem {
                Image(systemName: "person")
                Text("Profile")
            }.tag(Navigation.profile)
        }
    }
    
}
