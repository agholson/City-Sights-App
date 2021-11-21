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
                    ZStack(alignment: .top) {
                        BusinessMap(selectedBusiness: $selectedBusiness)
                            .ignoresSafeArea() // Makes the map use the full screen
                            .sheet(item: $selectedBusiness) { business in
                                
                                // Create a business detail view instance for the selected business
                                BusinessDetailView(business: business)
                    
                            }
                        
                        // Rectangle overlay to switch back to the list view
                        ZStack {
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(5)
                                .frame(height: 48)
                            
                            HStack {
                                // Display map icon
                                Image(systemName: "location")
                                
                                // Display the city name and state
                                if let city = model.placemark?.locality,
                                   let state = model.placemark?.administrativeArea {
                                    Text("\(city), \(state)")
                                }
                                
                                // Use Spacer to push elements left and right
                                Spacer()
                                
                                // Display city map list
                                Button {
                                    // Make the list view show on button click
                                    isMapShowing = false
                                } label: {
                                    Text("Switch to list view")
                                }
                            }
                            .padding()
                            
                        }
                        .padding()
                        
                    }
                    .navigationBarHidden(true) // Hides extra Navigation title space in the NavigationView, because the NavigationTitle is specified in the child view
                }
                else {
                    // MARK: List Businesses
                    // Show list of restaurants as child view to the Navigation View
                    VStack(alignment: .leading) {
                        
                        // MARK: Show location and toggle map button
                        HStack {
                            // Display map icon
                            Image(systemName: "location")
                            
                            // Display the city and state 
                            if let city = model.placemark?.locality,
                               let state = model.placemark?.administrativeArea {
                                Text("\(city), \(state)")
                            }
                            
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
                        ZStack(alignment: .top) {
                            
                            BusinessList()
                            
                            HStack {
                                // Push the Yelp icon to the right with the Spacer
                                Spacer()
                                // MARK: Yelp Icon
                                YelpAttribution(link: "https://yelp.com")
                            }
                            .padding(.trailing, -20) // Make the Yelp icon have no space on the right; up against edge
                            
                        }
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
