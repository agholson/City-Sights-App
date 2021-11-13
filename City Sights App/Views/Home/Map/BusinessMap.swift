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
    
}
