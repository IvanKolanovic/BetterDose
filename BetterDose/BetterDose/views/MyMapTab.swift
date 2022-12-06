

import SwiftUI
import CoreLocation
import MapKit

struct MyMapTab: View {
    
    @EnvironmentObject var farmacies: Farmacies
    
    @ObservedObject var lm = LocationManager()
    
    @State var isZoomed = false;
    
    var locationError: Bool { return lm.locationError ?? false}
    
    var selectedPark: Farmacy? { return farmacies.selectedFarmacy}
    
    @State private var mapView = MapView()
    
    var body: some View {
        ZStack{
            mapView
                .alert(isPresented: .constant(locationError)) {
                    Alert(title: Text("Location access denied"),
                          message: Text("Your location is needed"),
                          primaryButton: .cancel(),
                          secondaryButton: .default(Text("Settings"),
                                                    action: { self.goToDeviceSettings() }))
                }.onAppear {
                    print(mapView)
                    if selectedPark != nil {
                        print(mapView)
                        mapView.zoomIn(annotation: selectedPark!)
                        farmacies.selectedFarmacy = nil
                    } else {
                        print(mapView)
                        mapView.zoomOut()
                    }
                }
            Button(action: zoom){
                Label("", systemImage: "arrow.clockwise").font(Font.title.weight(.bold)).foregroundColor(.black)
            }.position(x:40,y:650)
        }.edgesIgnoringSafeArea(.top)
    }
    
    func zoom(){
        isZoomed = !isZoomed
        
        if(isZoomed){
            mapView.zoomToUser()
        }
        else if (!isZoomed) {
            mapView.zoomOut()
        }
    }
    
} //MyMapTab

extension MyMapTab {
    ///Path to device settings if location is disabled
    func goToDeviceSettings() {
        guard let url = URL.init(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}


struct MyMapTab_Previews: PreviewProvider {
    static var previews: some View {
        MyMapTab()
    }
}
