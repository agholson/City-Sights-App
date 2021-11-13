//
//  Constants.swift
//  City Sights App
//
//  Created by Shepherd on 11/11/21.
//

import Foundation

/*
 Holds variables, so if the API changes, we only need to chang it here
 */
struct Constants {
    
    // Static variables allow us to reference these properties without initializing an object of the Constants struct
    static var apiUrl = "https://api.yelp.com/v3/businesses/search"
    static var restaurantsKey = "restaurants"
    static var sightsKey = "arts"
    
    // Used in our BusinessMap view
    static var annotationReuseId = "business"
    
}
