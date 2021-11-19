//
//  DirectionsView.swift
//  City Sights App
//
//  Created by Shepherd on 11/16/21.
//

import SwiftUI

struct DirectionsView: View {
    
    // Need to modify the business in question
    var business: Business
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            
            HStack {
                // MARK: Business title
                BusinessTitle(business: business)
                    
                Spacer()
                // Create a link to open in Apple Maps
                // https://developer.apple.com/library/archive/featuredarticles/iPhoneURLScheme_Reference/MapLinks/MapLinks.html
                
                // If our coordinates exist, then display the Maps link
                if let lat = business.coordinates?.latitude,
                    let long = business.coordinates?.longitude,
                    let name = business.name {
                    // The q parameter will display the name of the destination in the Maps
                    // we encode the whole string, because businesses sometimes have names with apostrophes
                    Link(destination: URL(string: "http://maps.apple.com/?ll=\(lat),\(long)&q=\(name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)")!) {
                        Text("Open in maps")
                    }
                }

            }
            .padding()
            
            // Directions map
            DirectionsMap(business: business)
            
        }
        // Make the map use the entire screen without extra space at the bottom 
        .ignoresSafeArea(.all, edges: .bottom)
        
    }
}
