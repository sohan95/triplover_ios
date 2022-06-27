//
//  TripSegmentedView.swift
//  flightexpert
//
//  Created by sohan on 6/21/22.
//

import SwiftUI

struct TripSegmentedView: View {
    
    var typeSelected: String
    
    let name: String
    
    private var selected: Bool {
        return typeSelected == name
    }
    typealias Action = (String) -> Void
    var action: Action?
    
    var body: some View {
        Button(action: {
            //typeSelected = name
            // action
            if let action = action {
                action(name)
            }
        }, label: {
            HStack(alignment: .center, spacing: 1, content: {
                Text(name)
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundColor(self.selected ? Color("button-bg-color"): Color.white)
                
            })//: HSTACK
            .frame(width:100,height: 50)
            .background(self.selected ? Color.white.cornerRadius(5)
                        : Color("button-bg-color").cornerRadius(5))
        })//: BUTTON
    }
}

struct TripSegmentedView_Previews: PreviewProvider {
    static var previews: some View {
        TripSegmentedView(typeSelected: "One-Way", name: "One-Way")
    }
}
