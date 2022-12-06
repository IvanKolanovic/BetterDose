

import Foundation
import CoreLocation
import MapKit

class Farmacy: NSObject, MKAnnotation, Identifiable
{
    
    internal var id = UUID()
    
    private var name : String = ""
    
    private var city : String = ""
    
    private var country : String = ""
    
    private var link : String = ""
    
    private var latitude : Double = 0.0
    
    private var longitude : Double = 0.0
    
    private var location : CLLocation? = nil
    
    internal var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    internal var title: String? = ""
    
    internal var subtitle: String? = ""
    
    convenience override init () {
        self.init(name: "Unknown", city: "Unknown", country: "Unknown", link: "Unknown",latitude: 0.0, longitude: 0.0, location: nil, coordinate: CLLocationCoordinate2D(),title: "Unknown",subtitle: "Unknown")
    }
    
    init(name: String, city: String, country: String, link: String,latitude: Double, longitude: Double, location: CLLocation?,
         coordinate: CLLocationCoordinate2D,title:String,subtitle:String){
        super.init()
        self.setName(name)
        self.setCity( city)
        self.setCountry( country)
        self.setLink(link)
        self.setLatitude(latitude)
        self.setLongitude(longitude)
        self.setLocation(location)
        self.setCoordinate(coordinate)
        self.setTitle(title)
        self.setSubtitle(subtitle)
    }
    
    func getName() -> String {
        return self.name
    }
    
    func setName(_ name:String){
        self.name = name
    }
    
    func getCity() -> String {
        return self.city
    }
    
    func setCity(_ varr:String){
        self.city = varr
    }
    
    func getCountry() -> String {
        return self.country
    }
    
    func setCountry(_ varr:String){
        self.country = varr
    }
    
    func getLink() -> String {
        return self.link
    }
    
    func setLink(_ link: String) {
        self.link = link
    }
    
    
    func setLatitude(_ latitude: Double) {
        self.latitude = latitude
    }
    
    func setLongitude(_ longitude: Double) {
        self.longitude = longitude
    }
    
    func getLocation() -> CLLocation? {
        return self.location
    }
    
    func getLatitude() -> Double{
        return self.latitude
    }
    
    func getLongitude() -> Double{
        return self.longitude
    }
    
    func setLocation(_ location: CLLocation?) {
        self.location = location
    }
    
    func getCoordinate() -> CLLocationCoordinate2D {
        return self.coordinate
    }
    
    func setCoordinate(_ coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
    
    func getTitle() -> String? {
        return self.title
    }
    
    func setTitle(_ title: String?) {
        self.title = title
    }
    
    func getSubtitle() -> String? {
        return self.subtitle
    }
    
    func setSubtitle(_ subtitle: String?) {
        self.subtitle = subtitle
    }
    
}
