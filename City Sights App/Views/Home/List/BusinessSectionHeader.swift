//
//  BusinessSectionHeader.swift
//  City Sights App
//
//  Created by Shepherd on 11/11/21.
//

import SwiftUI

/*
 We use this re-useable view in order to prevent other elements in the list from overlapping with the headers
 */
struct BusinessSectionHeader: View {
    
    var title: String
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            
            Rectangle()
                .foregroundColor(.white)
            
            Text(title)
                .font(.headline)
        }
        
    }
}

struct BusinessSectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        BusinessSectionHeader(title: "Test Header")
    }
}
