//
//  OnboardingView.swift
//  City Sights App
//
//  Created by Shepherd on 11/18/21.
//

import SwiftUI

/*
 Displays at the startup of the app, and gets user's permission for the location
 */
struct OnboardingView: View {
    
    
    @EnvironmentObject var model: ContentModel
    // Used in our tab view
    @State var tabSelection = 0
    
    // Accepts the amount of green/ red/ blue as a Double e.g. 0 red, 130/255 green
    private let blue = Color(red: 0/255, green: 130/255, blue: 167/255)
    private let turqoise = Color(red: 55/255, green: 197/255, blue: 192/255)
    
    var body: some View {
        
        VStack {
            
            // MARK: Tab View
            TabView(selection: $tabSelection) {
                
                // First tab
                VStack(spacing: 20) {
                    Image("city2")
                        .resizable()
                        .scaledToFit()
                    Text("Welcome to City Sights")
                        .bold()
                        .font(.title)
                    Text("City Sights finds you the best of the city!")
                        
                }
                .multilineTextAlignment(.center)
                .tag(0)
                
                // Second tab
                VStack(spacing: 20) {
                    Image("city1")
                        .resizable()
                        .scaledToFit()
                    Text("Ready to discover your city?")
                        .bold()
                        .font(.title)
                    Text("We'll show you the best restaurants, venues, and more, based on your location!")
                }
                .multilineTextAlignment(.center)
                .tag(1)
                
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always)) // Displays the tab view with the dots at the bottom
            .foregroundColor(.white)
            
            // MARK: Button
            Button {
                // Detect the current tab
                if tabSelection == 0 {
                    // Then change it to the next tab
                    tabSelection = 1
                }
                // Else request fo the geolocation
                else {
                    model.requestGeolocationPermission()
                }
                
            } label: {
                
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 48)
                        .cornerRadius(10)
                    
                    Text(tabSelection == 0 ? "Next" : "Get my location")
                        .bold()
                        .padding()
                    
                }
                
            }
            .padding()
            .tint(tabSelection == 0 ? blue : turqoise) // If it's the first tab, make the button blue; else, turqoise
            
        }
        .background(tabSelection == 0 ? blue : turqoise)
        
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
