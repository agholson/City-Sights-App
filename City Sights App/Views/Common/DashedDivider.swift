//
//  DashedDivider.swift
//  City Sights App
//
//  Created by Shepherd on 11/21/21.
//

import SwiftUI

/*
 Displays a dashed divider used in the BusinessList and BusinessDetail views
 */
struct DashedDivider: View {
    var body: some View {
        // Use a GeometryReader to take up all the available space
        GeometryReader { geometry in
            
            Path { path in
                // Describes the starting point as top left corner
                path.move(to: CGPoint.zero)
                
                // Move our line on the horizontal
                path.addLine(to: CGPoint(x: geometry.size.width, y: 0))
                
            }
            // Creates our dashes
            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
            .foregroundColor(.gray)
        }
        // Keeps the Reader from taking other space
        .frame(height: 1)
        
        
    }
}

struct DashedDivider_Previews: PreviewProvider {
    static var previews: some View {
        DashedDivider()
    }
}
