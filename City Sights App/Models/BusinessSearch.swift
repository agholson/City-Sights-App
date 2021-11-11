//
//  BusinessSearch.swift
//  City Sights App
//
//  Created by Shepherd on 11/11/21.
//

import Foundation

/*
 Represents a business search from the Yelp API. Corresponds to results from the following endpoint:
 https://www.yelp.com/developers/documentation/v3/business_search
 */
struct BusinessSearch: Decodable {
    // Expect that all of these parameters exist in each call
    // Initialize to empty business array
    var businesses = [Business]()
    var total = 0
    var region = Region()
}

struct Region: Decodable {
    var center = Coordinates()
}


