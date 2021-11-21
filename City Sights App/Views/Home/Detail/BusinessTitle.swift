//
//  BusinessTitle.swift
//  City Sights App
//
//  Created by Shepherd on 11/16/21.
//

import SwiftUI

struct BusinessTitle: View {
    
    var business: Business
    
    var body: some View {
        
        VStack(alignment: .leading) {
            // Business name
            Text(business.name ?? "")
                .font(.title2)
                .bold()
            
            // Loop through the displayAddress
            if business.location?.displayAddress != nil { // only do this, if these are not nil
                ForEach(business.location!.displayAddress!, id: \.self) { displayLine in
                    Text(displayLine)
                }
            }

            // Star rating - the 1.5, 4.5 rating from the API corresponds to the image name
            Image("regular_\(business.rating ?? 0)")
        }
    }
}
