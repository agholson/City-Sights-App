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
    
    @Published var restaurants = [Business]()
    @Published var sights = [Business]()
    
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
     Another delegate we handle, which displays the location of the user. It will also call the Yelp API to get a set of the businesses
     This function keeps getting the user's updated location, unless explicitly told to stop.
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Grabs the user's first location
        let userLocation = locations.first
        
        // If we get the user's location, then we don't need to continue asking for it
        if userLocation != nil {
            locationManager.stopUpdatingLocation()
            
            // MARK: Call Yelp API
            // Grab the arts category
            getBusinesses(category: Constants.sightsKey, location: userLocation!)
            
            // Grabs the restaurants in the area
            getBusinesses(category: Constants.restaurantsKey, location: userLocation!)
        }
        
//        print(locations.first ?? "No location yet")
        // Prints lat/ long, elevation, speed, and course
        // <+37.35955814,-122.11901575> +/- 5.00m (speed 34.59 mps / course 333.98) @ 11/10/21, 9:34:05 PM Eastern Standard Time
        
        
    }
    
    
    // MARK: Yelp API Methods
    
    /*
     Calls the Yelp API to get businesses based on the category and location given
     */
    func getBusinesses(category:String, location: CLLocation) {
        // Create URL with the Yelp endpoint for our location
        // Reference: https://www.yelp.com/developers/documentation/v3/business_search
        /*
        let urlString = "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)&categories=\(category)&limit=6"
        
        let url = URL(string: urlString)
        */
        // Create URLComponents object with base API string
        var urlComponents = URLComponents(string: Constants.apiUrl)
        
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
            // Add Authorization headers with our API key
            request.addValue("Bearer \(YelpAPICreds.apiKey)", forHTTPHeaderField: "Authorization")
            
            // Get URLSession
            let session = URLSession.shared
            
            // Create Data Task
            let dataTask = session.dataTask(with: request) { data, response, error in
                
                // Check that no errors occurred
                if error == nil {
                   
                    // MARK: Parse API Response into BusinessSearch object
                    let decoder = JSONDecoder()
                    
                    do {
                        // Decode the response into a BusinessSearch object
                        let result = try decoder.decode(BusinessSearch.self, from: data!)
                        
                        // Assigning to properties from the background thread (network dataTask)
                        DispatchQueue.main.async {
                            // Decode into restaurant or sight properties
//                            if category == Constants.restaurantsKey {
//                                self.restaurants = result.businesses
//                            }
//                            else if category == Constants.sightsKey {
//                                self.sights = result.businesses
//                            }
//                            else {
//                                print("Error: called a category not accepted. Category supplied: \(category)")
//                            }
                            
                            // Use Case versus the if statements above for a cleaner, more scalable look
                            switch category {
                            case Constants.sightsKey:
                                self.sights = result.businesses
                            case Constants.restaurantsKey:
                                self.restaurants = result.businesses
                            // Does this if none of the other cases match
                            default:
                                print("Error: could not decode into category not defined. Category supplied: \(category)")
                                break
                            }
                            
                        }
                       
                    }
                    catch {
                        // Print any decode errors
                        print(error)
                    }
                    
                }
                
                
            }
            
            // Start the Data Task
            dataTask.resume()
            
        }
        
        
        
    }
    
    
}
