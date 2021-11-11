//
//  BusinessList.swift
//  City Sights App
//
//  Created by Shepherd on 11/11/21.
//

import SwiftUI

struct BusinessList: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        ScrollView {
            
            // Pinned Views keeps the headers at the top, like in Excel, where you scroll down and its still visible
            LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]) {
                
                // MARK: Restaurants
                BusinessSection(title: "Restaurants", businesses: model.restaurants)
                
                // MARK: Sights
                BusinessSection(title: "Sights", businesses: model.sights)
                
            }
            
            
        }
    }
}

struct BusinessList_Previews: PreviewProvider {
    static var previews: some View {
        BusinessList()
    }
}
