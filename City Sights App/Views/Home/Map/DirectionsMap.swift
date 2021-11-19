//
//  DirectionsMap.swift
//  City Sights App
//
//  Created by Shepherd on 11/16/21.
//

import MapKit
import SwiftUI

/*
 Need to use UIKit with the MapView
 */
struct DirectionsMap: UIViewRepresentable {
    
    // Access the LocationManager property of the ContentModel for the user's location
    @EnvironmentObject var model: ContentModel
    
    // Need to get the business for its address/ name
    var business: Business
    
    var start: CLLocationCoordinate2D {
        // Return the user's location, or if nil, an empty location point
        return model.locationManager.location?.coordinate ?? CLLocationCoordinate2D()
    }
    
    var end: CLLocationCoordinate2D {
        
        if let lat = business.coordinates?.latitude,
           let long = business.coordinates?.longitude {
            return CLLocationCoordinate2D(latitude: lat, longitude: long)
        }
        else {
            return CLLocationCoordinate2D()
        }
    }
    
    func makeUIView(context: Context) -> MKMapView {
        // Displays a map
        let map = MKMapView()
        
        // Need to use a delegate in order to place the points on the map
        map.delegate = context.coordinator
        
        // Show the user's location on the map
        map.showsUserLocation = true
        map.userTrackingMode = .followWithHeading
        
        // Create directions request
        let request = MKDirections.Request()
        // Add the starting coordinate
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: start))
        
        // Add the destination coordinate
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: end))
        
        // Create directions object
        let directions = MKDirections(request: request)
        
        // Calculate route
        directions.calculate { response, error in
            // Make sure no errors occurred
            if error == nil && response != nil {
                // Go through each of the routes
                for route in response!.routes {
                    // Plot the routes on the map
                    map.addOverlay(route.polyline)
                    
                    // Make the map zoom in on our routes
                    map.setVisibleMapRect(
                        route.polyline.boundingMapRect,
                        edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100),
                        animated: true
                    )
                    
                }
            }
        }
        
        // Place annotation for the end point
        let annotation = MKPointAnnotation()
        annotation.coordinate = end
        annotation.title = business.name ?? ""
        
        // Add it to the map
        map.addAnnotation(annotation)
        
        return map
        
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
           
        
    }
    
    /*
     Tear down the map
     */
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        // Removes the pin points/ annotations on the map
        uiView.removeAnnotations(uiView.annotations)
        
        // Removes the lines, or overlays on the map
        uiView.removeOverlays(uiView.overlays)
        
    }
    
    // MARK: Coordinators
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            
            // Need a new renderer to render our polylines
            let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
            
            renderer.strokeColor = .blue
            renderer.lineWidth = 5
            
            return renderer
            
        }
        
    }
    
}
