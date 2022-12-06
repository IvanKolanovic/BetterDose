

import SwiftUI
import CoreLocation
import MapKit

class Farmacies: ObservableObject {
    @State var farmacies: [Farmacy] = []
    @Published var list: [Farmacy] = []
    @State var selectedFarmacy: Farmacy?
    @State var locationManager = CLLocationManager()
    @State var dataManager: FirestoreDataManager = FirestoreDataManager()

    init() {
        //load data
        if let path = Bundle.main.path(forResource: "data", ofType: "plist") {
                    
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let tempDict = try PropertyListSerialization.propertyList(from: data, format: nil) as! [String:Any]
                print("\(String.init(describing: tempDict))")
                let tempArray = tempDict["farmacies"]! as! Array<[String:Any]>
                
                var temp: [Farmacy] = []
                for dict in tempArray {
                    print("\(dict)")
                    let name = dict["name"]! as! String
                    let city = dict["city"]! as! String
                    let country = dict["country"]! as! String
                    let link = dict["link"]! as! String
                    let latitude = Double(dict["latitude"]! as! String)!
                    let longitude = Double(dict["longitude"]! as! String)!
                    let location = CLLocation(latitude: latitude, longitude: longitude)
                    let address = dict["address"]! as! String

                    
                    let p = Farmacy(name: name, city: city, country: country, link: link, latitude: latitude, longitude: longitude, location: location, coordinate: location.coordinate,title: name, subtitle: address)
                    temp.append(p)
                }
                
                //assign to state variable
                _farmacies = State(initialValue: temp)
                
//                UISegmentedControl.appearance().selectedSegmentTintColor = .white
//                UISegmentedControl.appearance().selectedSegmentTintColor = .blue
//                
//                UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.white], for: .selected)
//                UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.blue], for: .normal)

                self.list = temp.sorted(by:{ $0.getName() < $1.getName() })
                startUpdating()
            } catch {
                print(error)
            }
        }
        
        func startUpdating(){
            locationManager.startUpdatingLocation()
        }
    
    }
}

