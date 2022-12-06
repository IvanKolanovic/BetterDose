import SwiftUI
import Firebase

@main
struct BetterDoseApp: App {
    
    @StateObject var farmacies: Farmacies = Farmacies()
    
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(farmacies)
        }
    }
}
