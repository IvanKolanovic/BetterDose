

import Foundation
import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @EnvironmentObject var farmacies: Farmacies
    let mapView = MKMapView()
    
    /**
     - Description - Replace the body with a make UIView(context:) method that creates and return an empty MKMapView
     */
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: UIViewRepresentableContext<MapView>) {
        mapView.showsUserLocation = true
        mapView.addAnnotations(farmacies.list)
    }

    
    func makeCoordinator() -> Coordinator {
       Coordinator(self)
    }
    
    func zoomIn(annotation: MKAnnotation) {
        let region = MKCoordinateRegion.init(center: annotation.coordinate, latitudinalMeters: 20000,longitudinalMeters: 20000)
        mapView.setRegion(region,animated: true)
    }
    
    func zoomIn(cord: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion.init(center: cord, latitudinalMeters: 20000,longitudinalMeters: 20000)
        mapView.setRegion(region,animated: true)
    }
    
    func zoomOut() {          
        mapView.showAnnotations(mapView.annotations, animated:   true)
    }
    
    func zoomToUser(){
        mapView.setRegion(MKCoordinateRegion(center:mapView.userLocation.coordinate,span: MKCoordinateSpan(latitudeDelta: 0.18, longitudeDelta: 0.18)), animated: true)
    }

    
    class Coordinator: NSObject, MKMapViewDelegate
    {
        
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            //print(mapView.centerCoordinate)
        }
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {

        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            let annotation = view.annotation
            print("The title of the annotation is: \(String(describing: annotation?.title))")
        }
        
        // This delegate method is called once for every annotation that is created.
        // If no view is returned by this method, then only the default pin is seen by the user
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
                var view: MKMarkerAnnotationView
                let identifier = "Pin"
                
                if annotation is MKUserLocation {
                    //if annotation is not an MKPointAnnotation (eg. MKUserLocation),
                    //return nil so map draws default view for it (eg. blue dot)...
                    return nil
                }
                if annotation !== mapView.userLocation   {
                    //look for an existing view to reuse
                    if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                        as? MKMarkerAnnotationView {
                        dequeuedView.annotation = annotation
                        view = dequeuedView
                    } else {
                        view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                        view.markerTintColor = UIColor.purple
                        view.animatesWhenAdded = true
                        view.canShowCallout = true
                        //view.calloutOffset = CGPoint(x: -5, y: 5)
                        let leftButton = UIButton(type: .infoLight)
                        let rightButton = UIButton(type: .detailDisclosure)
                        leftButton.tag = 0
                        rightButton.tag = 1
                        view.leftCalloutAccessoryView = leftButton
                        view.rightCalloutAccessoryView = rightButton
                    }
                    return view
                }
                
                return nil
            }
            
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            print("Control tapped: \(control), tag number=\(control.tag)")
            let annot = view.annotation as! Farmacy
            switch control.tag {
            case 0:
                if let url = URL(string: annot.getLink()){
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)                }
            case 1:
                let place = MKPlacemark(coordinate: annot.getLocation()!.coordinate, addressDictionary: nil)
                let mapItem = MKMapItem(placemark: place)
                mapItem.name = annot.getName()
                let options = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
                mapItem.openInMaps( launchOptions: options)
            default:
                break
            }
        }
    } //Coordinator


} //MapView
