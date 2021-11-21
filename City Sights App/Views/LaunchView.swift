//
//  ContentView.swift
//  City Sights App
//
//  Created by Shepherd on 11/8/21.
//

import SwiftUI

struct LaunchView: View {
    
    // Inherit our ContentModel, which contains everything
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        // Detect the authorization status by geolocating the user
        if model.authorizationState == .notDetermined {
            // If undetermined show onboarding screen
            OnboardingView()
        }
        else if model.authorizationState == .authorizedWhenInUse
                    || model.authorizationState == .authorizedAlways {
            // SHow the HomeView
            HomeView()
        }
        else {
            LocationDeniedView()
        }
                
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
       LaunchView()
    }
}
