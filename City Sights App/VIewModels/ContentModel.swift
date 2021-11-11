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
    /*
     Checks the status of the CLLocationManager to determine, if user granted us access to the location
     */
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
     Another delegate we handle, which displays the location of the user.
     This function keeps getting the user's updated location, unless explicitly told to stop
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Grabs the user's first location
        let userLocation = locations.first
        
        // If we get the user's location, then we don't need to continue asking for it
        if userLocation != nil {
            locationManager.stopUpdatingLocation()
            
            // MARK: Call Yelp API
            // Grab the arts category
//            getBusinesses(category: "arts", location: userLocation!)
            
            // Grabs the user location
            getBusinesses(category: "restaurants", location: userLocation!)
        }
        
//        print(locations.first ?? "No location yet")
        // Prints lat/ long, elevation, speed, and course
        // <+37.35955814,-122.11901575> +/- 5.00m (speed 34.59 mps / course 333.98) @ 11/10/21, 9:34:05 PM Eastern Standard Time
        
        
    }
    
    
    // MARK: Yelp API Methods
    
    
    func getBusinesses(category:String, location: CLLocation) {
        // Create URL with the Yelp endpoint for our location
        // Reference: https://www.yelp.com/developers/documentation/v3/business_search
        /*
        let urlString = "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)&categories=\(category)&limit=6"
        
        let url = URL(string: urlString)
        */
        // Create URLComponents object with base API string
        var urlComponents = URLComponents(string: "https://api.yelp.com/v3/businesses/search")
        
        // Add the query parameters
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "6")
        ]
        
        let url = urlComponents?.url
        
        // If the url is not nil, then proceed (because above are optional variables)
        if let url = url {
            
            // Create a URL Request, which always fetches new data from the server, and times out after 10 seconds
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            
            // See ProdEnvExample on how to insert your API credentials
            let apiCreds = YelpAPICreds()
            
            // Add Authorization headers with our API key
            request.addValue("Bearer \(apiCreds.apiKey)", forHTTPHeaderField: "Authorization")
            
            // Get URLSession
            let session = URLSession.shared
            
            // Create Data Task
            let dataTask = session.dataTask(with: request) { data, response, error in
                
                // Check that no errors occurred
                if error == nil {
                    print(response)
                }
                
                
            }
            
            // Start the Data Task
            dataTask.resume()
            
        }
        
        
        
    }
    
    
}
