//
//  Business.swift
//  City Sights App
//
//  Created by Shepherd on 11/11/21.
//

import Foundation

/*
 Business model that corresponds to business data received from the Yelp API
 
 ObservableObject allows us to update views, as soon as Business's properties change
 */
class Business: Decodable, Identifiable, ObservableObject {
    
    // Holds the image, we download later
    @Published var imageData: Data?
    
    // Make all of our attributes optional, in case the API doesn't return one of them
    var id: String?
    var alias: String?
    var name: String?
    // Note that the property names must correspond exactly to the JSON key name. We will change this later though
    var imageUrl: String?
    var isClosed: Bool?
    var url: String?
    var reviewCount: Int?
    var categories: [Category]?
    var rating: Double?
    var coordinates: Coordinates?
    // Array of strings, versus JSON, so no need for new struct
    var transactions: [String]?
    var price: String?
    var location: Location?
    var phone: String?
    var displayPhone: String?
    var distance: Double?
    
    // Maps keys that do not conform to came case for us here
    enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
        case isClosed = "is_closed"
        case reviewCount = "review_count"
        case displayPhone = "display_phone"
        
        // However, we must have these keys defined as well
        case id
        case alias
        case name
        case url
        case categories
        case rating
        case coordinates
        case transactions
        case price
        case location
        case phone
        case distance
    }
    
    // Downloads the associated image for each business
    func getImageData() {
        
        // Check that URL is not nil
        guard imageUrl != nil else {
            return
        }
        
        // Download data for the image
        if let url = URL(string: imageUrl!) {
            
            // Get a session
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: url) { data, response, error in
                
                // If no error, then set the image data
                if error == nil {
                    
                    DispatchQueue.main.async {
                        // Set the image property here
                        self.imageData = data
                        
                    }
                    
                }
                
            }
            
            dataTask.resume()
            
            
        }
        
        
    }
    
    func getTestData() -> Business {
        let b = Business()
        
        // TODO: Set all of the business parameters
        
        
        // Return the business
        return b
    }
    
}

struct Location: Decodable {
    var address1: String?
    var address2: String?
    var address3: String?
    var city: String?
    var zipCode: String?
    var country: String?
    var state: String?
    var displayAddress: [String]?
    
    enum CodingKeys: String, CodingKey {
        case zipCode = "zip_code"
        case displayAddress = "display_address"
        
        case address1
        case address2
        case address3
        case city
        case country
        case state
    }
    
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
