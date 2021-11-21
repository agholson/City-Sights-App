//
//  LocationDeniedView.swift
//  City Sights App
//
//  Created by Shepherd on 11/19/21.
//

import SwiftUI

struct LocationDeniedView: View {
    
    private let backgroundColor = Color(red: 34/255, green: 141/255, blue: 138/255)
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Spacer()
            
            Text("Whoops!")
                .font(.title)
            
            Text("We need your location to provide you with the best sites in the city. You can change this at any time in the Settings.")
            
            Spacer()
            
            Button {
                // Open settings
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    
                    // Determines whether/ not it can open the URL
                    if UIApplication.shared.canOpenURL(url) {
                        // Open the URL 
                        UIApplication.shared.open(url)
                    }
                    
                    
                }
            } label: {
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 48)
                        .cornerRadius(10)
                    
                    Text("Go to Settings")
                        .bold()
                        .foregroundColor(backgroundColor)
                        .padding()
                }
            }
            .padding()
            
            Spacer()
            
        }
        .padding()
        .foregroundColor(.white)
        .multilineTextAlignment(.center)
        .background(backgroundColor)
        .ignoresSafeArea(.all, edges: .all)

        
    }
}

struct LocationDeniedView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDeniedView()
    }
}
