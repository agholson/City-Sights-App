//
//  YelpAttribution.swift
//  City Sights App
//
//  Created by Shepherd on 11/21/21.
//

import SwiftUI

/*
 Make the Yelp icon a link to the Yelp website
 */
struct YelpAttribution: View {
    
    var link: String
    
    var body: some View {

        Link(destination: URL(string: link)!) {
            Image("yelp")
                .resizable()
                .scaledToFit()
                .frame(height:36)
        }
    }
}
