//
//  BusinessRow.swift
//  City Sights App
//
//  Created by Shepherd on 11/11/21.
//

import SwiftUI

struct BusinessRow: View {
    
    // Allows it to update the photo for the business as soon as it gets it
    @ObservedObject var business: Business
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                // MARK: Business Image
                // Load the data from the property, else make it an empty data object
                let uiImage = UIImage(data: business.imageData ?? Data())
                
                // Place image on the screen, if nil, then make it an empty UIImage
                Image(uiImage: uiImage ?? UIImage())
                    .resizable() // Makes sure it resizes image to fit in our frame, resizable goes at top to modify image, versus other mods
                    .frame(width: 58, height: 58)
                    .cornerRadius(5)
                    .scaledToFit() // Keeps aspect ratio
                
                // Name and distance
                VStack(alignment: .leading) {
                    Text(business.name ?? "")
                        .fontWeight(.bold)
                    // Rounds our distance to one floating point, and divides it into kilometers
                    Text(String(format: "%.1f km. away", (business.distance ?? 0)/1000 ) )
                        .font(.caption)
                    
                }
                
                // Pushes star ratings all the way right
                Spacer()
                
                // Star rating and number of reviews
                VStack(alignment: .leading) {
                    // Star rating - the 1.5, 4.5 rating from the API corresponds to the image name
                    Image("regular_\(business.rating ?? 0)")
                    
                    // Number of reviews
                    Text("\(business.reviewCount ?? 0) Reviews")
                        .font(.caption) // Makes appear in gray
                }
                
            }
            
        }
        
        Divider()
        
    }
}
