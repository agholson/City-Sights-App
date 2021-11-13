//
//  BusinessMap.swift
//  City Sights App
//
//  Created by Shepherd on 11/13/21.
//

import SwiftUI
import MapKit

/*
 Displays a map for the user with all of the businesses using UIKit's MKMapView
 */
struct BusinessMap: UIViewRepresentable {
    
    @EnvironmentObject var model: ContentModel
    
    /*
     Computed property displays the business name, and an information icon when called
     */
    var locations: [MKPointAnnotation] {
        
        // Create empty array of MKAnnotations
        var annotations = [MKPointAnnotation]()
        
        // Create a set of annotations from our list of businesses
        // Loop through both of the businesses at once
        for business in model.restaurants + model.sights {
            
            // Make sure the coordinates exist, otherwise skip this code
            if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude {
            
                // Create a new annotation
                let annotation = MKPointAnnotation()
                
                // Add the coorindates from the business
                annotation.coordinate = CLLocationCoordinate2D(
                    latitude: lat,
                    longitude: long
                )
                
                // If user taps on the pin, then they see this name
                annotation.title = business.name ?? ""
                
                // Add to our list of annotations
                annotations.append(annotation)
                
            }
            
        }
        
        return annotations
    }
    
    /*
     Makes the UIKit View
     */
    func makeUIView(context: Context) -> MKMapView {
        
        let mapView = MKMapView()
        
        // Allows us to display extra information with a click on the pins
        // The system will call below makeCoordinator, then if it already exists, it will use the existing one
        mapView.delegate = context.coordinator
        
        // Display user on map
        mapView.showsUserLocation = true
        
        // Changes the map to follow the user, as well as the directions the user turns
        mapView.userTrackingMode = .followWithHeading
        
        // Would need to set the region, if we did not zoom in on our map points
            
        return mapView
        
    }
    
    /*
     Adds the business location pins to the map
     Allows us to update properties within the view.
     */
    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Remove all previous business location pins
        uiView.removeAnnotations(uiView.annotations)
        
        // Add the map annotations we care about from the computed property above
//        uiView.addAnnotations(self.locations)
        // Zooms in on the map to display all of our locations on the same screen
        uiView.showAnnotations(self.locations, animated: true)
    }
    
    /*
     Tears down UIKit view
     */
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        // Remove the map annotations
        uiView.removeAnnotations(uiView.annotations)
    }
    
    // MARK: Coordinator Class
    
    /*
     This makeCoordinator is an optional method with the MKMapView
     */
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    /*
     Coordinator class allows us to implement custom MKMapViewDelegate class, which handles UI events on the screen
     
     Coordinator only available inside of this struct
     
     Inherits from NSObject, because MKMapViewDelegate needs to be subclass of the NSObject class.
     */
    class Coordinator: NSObject, MKMapViewDelegate {
     
        // Creates an annotation with the business name for every single annotation on the map
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            // If the annotation represent's the user's blue dot, then return nil.
            // Without this, the user's locationd does not display on the map
            if annotation is MKUserLocation { // sees if the annotation is the type MKUserLocation versus MKAnnotation
                return nil
            }
            
            // Check if we can re-use an annotation view, versus create one first
            // Returns optional annotationView we set below, if it did not exist
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.annotationReuseId)
            
            // If the above annotationView is nil, then create a new one
            if annotationView == nil {
                // Create an annotation view
                // Reuse identifier allows us to use one of the current annotations that may not be on the screen, versus showing a new one,
                // creating a new object in memory
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: Constants.annotationReuseId)
                
                // Allows us to display extra information in a callout bubble
                annotationView!.canShowCallout = true
                
                // Creates a small I information icon with the .detailDisclosur, the user can click to show details of the business
                annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }
            else {
                // Means we have a reusable annotation view, so we assign the old annotation to this one
                annotationView!.annotation = annotation
            }
            
            // Return it
            return annotationView
            
        }
        
    }
    
}
