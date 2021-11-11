//
//  ContentModel.swift
//  City Sights App
//
//  Created by Shepherd on 11/8/21.
//

import Foundation
import CoreLocation  // Gets user's location

/*
 Connects to the Yelp API
 Gets user's location
 
 ObservableObject protocol allows other views to inherit from this
 
 ContentModel is the delegate of the LocationManager through the CLLocationManagerDelegate protocol
 This means we need to inherit from the Objective-C NSObject
 */
class ContentModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    // Create a CoreLocation Manager object
    var locationManager = CLLocationManager()
    
    // Overrides the NSObject's init method
    override init() {
        // Call the init of the superclass, the NSObject
        super.init()
        
        // Set the contentModel as the delegate of the location manager
        locationManager.delegate = self
        
        // Request user's location permission
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    // MARK: - Location Manager Delegate Methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // Check the current status of authroization
        if locationManager.authorizationStatus == .authorizedAlways ||
            locationManager.authorizationStatus == .authorizedWhenInUse {
            
            // We have permission to use the location
            locationManager.startUpdatingLocation()
            
        }
        else if locationManager.authorizationStatus == .denied {
            // pop-up message that we need location to get
        }
        
    }
    
    /*
     Another delegate we handle, which displays the location of the user
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Gives location of user - keeps firing
        print(locations.first ?? "No location yet")
        // Prints lat/ long, elevation, speed, and course
        // <+37.35955814,-122.11901575> +/- 5.00m (speed 34.59 mps / course 333.98) @ 11/10/21, 9:34:05 PM Eastern Standard Time
        
        // TODO: if we have user coordinates send to Yelp API
        
        
        // Otherwise, we can stop requesting the location after getting it once
        locationManager.stopUpdatingLocation()
    }
    
}
