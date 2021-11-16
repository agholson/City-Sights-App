//
//  HomeView.swift
//  City Sights App
//
//  Created by Shepherd on 11/11/21.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    
    // Tracks whether/ not to show the map view
    @State var isMapShowing = false
    
    // Business used in the MapView
    @State var selectedBusiness: Business?
    
    var body: some View {
        
        
        if model.restaurants.count != 0 || model.sights.count != 0 {
            
            NavigationView {
                
                // Determine if we show list or map data
                if isMapShowing {
                    
                    // MARK: Map of Places
                    
                    BusinessMap(selectedBusiness: $selectedBusiness)
                        .ignoresSafeArea() // Makes the map use the full screen
                        .sheet(item: $selectedBusiness) { business in
                            
                            // Create a business detail view instance for the selected business
                            BusinessDetailView(business: business)
                            
                            
                            
                        }
                }
                else {
                    // MARK: List Businesses
                    // Show list of restaurants as child view to the Navigation View
                    VStack(alignment: .leading) {
                        
                        // MARK: Show location and toggle map button
                        HStack {
                            // Display map icon
                            Image(systemName: "location")
                            
                            // Display the city name and state
                            Text("\(model.restaurants.first?.location?.city ?? ""), \(model.restaurants.first?.location?.state ?? "")")
                            
                            // Use Spacer to push elements left and right
                            Spacer()
                            
                            // Display city map view
                            Button {
                                // Make the map view show on click
                                isMapShowing = true
                            } label: {
                                Text("Switch to map view")
                            }
                        }
                        
                        Divider()
                        
                        // MARK: Display list of restaurants
                        BusinessList()
                        
                    }
                        // Add padding to all of the elements in our VSTack
                        .padding([.horizontal, .top])
                        .navigationBarHidden(true) // Add modifier to child view, not to the NavigationView itself
                    
                    
                }
                
            }
            
        }
        // If there are no restaurants or sites, then show a loading bar
        else {
            // Still waiting for data from the Yelp API
            ProgressView()
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
