//
//  City_Sights_AppApp.swift
//  City Sights App
//
//  Created by Shepherd on 11/8/21.
//

import SwiftUI

@main
struct CitySightsApp: App {
    var body: some Scene {
        WindowGroup {
            // Make child views able to inherit from this ContentModel object
            LaunchView()
                .environmentObject(ContentModel())
        }
    }
}
