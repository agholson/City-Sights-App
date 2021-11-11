//
//  Business.swift
//  City Sights App
//
//  Created by Shepherd on 11/11/21.
//

import Foundation

/*
 Business model that corresponds to business data received from the Yelp API
 */
struct Business: Decodable, Identifiable {
    
    // Make all of our attributes optional, in case the API doesn't return one of them
    var id: String?
    var alias: String?
    var name: String?
    // Note that the property names must correspond exactly to the JSON key name. We will change this later though
    var image_url: String?
    var is_closed: Bool?
    var url: String?
    var review_count: Int?
    var categories: [Category]?
    var rating: Double?
    var coordinates: Coordinates?
    // Array of strings, versus JSON, so no need for new struct
    var transactions: [String]?
    var price: String?
    var location: Location?
    var phone: String?
    var display_phone: String?
    var distance: Double?
}

struct Location: Decodable {
    var address1: String?
    var address2: String?
    var address3: String?
    var city: String?
    var zip_code: String?
    var country: String?
    var state: String?
    var displayAddress: [String]?
}

/*
 Category objected nested within the Business
 Make a new struct for each JSON object
 */
struct Category: Decodable {
    var alias: String?
    var title: String?
}

struct Coordinates: Decodable {
    var latitude: Double?
    var longitude: Double?
}
