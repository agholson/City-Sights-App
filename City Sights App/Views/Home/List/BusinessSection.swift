//
//  BusinessSection.swift
//  City Sights App
//
//  Created by Shepherd on 11/11/21.
//

import SwiftUI

/*
 Displays our list of businesses
 */
struct BusinessSection: View {
    
    var title: String
    var businesses: [Business]
    
    var body: some View {
        
        Section(header:  BusinessSectionHeader(title: title)) {
        
            ForEach(businesses) { business in
                
                NavigationLink(destination: BusinessDetailView(business: business)) {
                    BusinessRow(business: business)
                }
                
            }
            
        }
    }
}
