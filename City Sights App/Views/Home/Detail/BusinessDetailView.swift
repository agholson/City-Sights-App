//
//  BusinessDetailView.swift
//  City Sights App
//
//  Created by Shepherd on 11/11/21.
//

import SwiftUI

struct BusinessDetailView: View {
    
    var business: Business
    
    /*
     Use computed status to display whether/ not the business is open. Otherwise, it would appear like true, or false
     */
    var businessOpenText: String {
        guard business.isClosed != nil else {
            return "Could not determine business status"
        }
        
        if business.isClosed! {
            return "Closed"
        }
        else {
            return "Open"
        }
        
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            // Use a VSTack here with spacing 0, so elements have no padding between
            VStack(alignment:.leading, spacing: 0) {
                // MARK: Display image at top
                // Use a GeometryReader, so it takes up all space we give it
                GeometryReader() { geometry in
                    // Load the image, or make it have an empty
                    let uiImage = UIImage(data: business.imageData ?? Data())
                    Image(uiImage: uiImage ?? UIImage())
                        .resizable()
                        .scaledToFill() // Maintains aspect ratio
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped() // Binds image to its view, so it does not spill over
                    
                }
                .ignoresSafeArea(.all, edges: .top) // Ignores the safe area in the app
                
               
                // MARK: Display whether/ not it closed along with a rectangle with a blue bar
                ZStack(alignment:.leading) { // Sometimes this forces the element to use entire space
                    // Display whether/ not it is open with computed property
                    Rectangle()
                    // If the business is closed, we dispaly gray, else blue
                        .foregroundColor(business.isClosed ?? true ? .gray : .blue)
                        .frame(height: 36)
                    
                    // If it is closed, isClosed == true, then use text "Closed" else "Open"
                    Text(business.isClosed ?? true ? "Closed" : "Open")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.leading) // Make it so the Closed/ open does not sit right against the left
                    
                }
            }
            // Group all of the elements below, because ZSTack can only display up to 10 elements without Group
            Group {
                
                // MARK: Business name and address
                // Business name
                Text(business.name ?? "")
                    .font(.largeTitle)
                    .padding()
                
                // Loop through the displayAddress
                if business.location?.displayAddress != nil { // only do this, if these are not nil
                    ForEach(business.location!.displayAddress!, id: \.self) { displayLine in
                        Text(displayLine)
                            .padding(.horizontal) // Only add padding left/ right
                    }
                }
        
                // Star rating - the 1.5, 4.5 rating from the API corresponds to the image name
                Image("regular_\(business.rating ?? 0)")
                    .padding()
                
                Divider()
                
                // MARK: Phone
                HStack {
                    // phone number
                    Text("Phone")
                        .bold()
                    
                    // Show the number
                    Text(business.displayPhone ?? "")
                    
                    // Push elements as far away left/ right
                    Spacer()
                    
                    // Display a link to launch the phone app
                    Link(destination: URL(string: "tel:\(business.phone ?? "")")!) {
                        Text("Call")
                    }
                }
                .padding() // Generates extra space to make image smaller
                
                Divider()
                
                // MARK: Reviews
                HStack {
                    //
                    Text("Reviews: ")
                        .fontWeight(.bold)
                    
                    Text("\(business.reviewCount ?? 0)")
                    
                    Spacer()
                    
                    Link(destination: URL(string: business.url ?? "")! ) {
                        Text("Read")
                    }
                }
                .padding()
                
                Divider()
                
                // MARK: Website
                HStack {
                    //
                    Text("Website: ")
                        .fontWeight(.bold)
                    
                    Text("\(business.url ?? "")")
                        .lineLimit(1)  // Limits the line to 1
                    
                    Link(destination: URL(string: business.url ?? "")! ) {
                        Text("Visit")
                    }
                }
                .padding()
                
                // MARK: Get Directions Button
                Button {
                    // TODO: MapView()
                } label: {
                    ZStack {
                        
                        Rectangle()
                            .frame(height: 48)
                            .foregroundColor(.blue)
                            .cornerRadius(10)
                        
                        Text("Get Directions")
                            .foregroundColor(.white)
                            .bold()
                        
                    }
                }
                .padding()

            
            }
        }
        
    }
}
