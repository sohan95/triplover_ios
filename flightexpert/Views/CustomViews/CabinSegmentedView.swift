//
//  CabinSegmentedView.swift
//  flightexpert
//
//  Created by sohan on 6/21/22.
//

import SwiftUI

struct CabinSegmentedView: View {
    
    @Binding var cabinSelected: String
    
    let name: String
    
    private var selected: Bool {
        return cabinSelected == name
    }
    
    func test() {
        
    }
    
    var body: some View {
        Button(action: {
            cabinSelected = name
            print("typeSelected=\(cabinSelected)")
        }, label: {
            HStack(alignment: .center, spacing: 1, content: {
                Text(name)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .font(.system(size: 11))
                
            })//: HSTACK
            .frame(width:70,height:50)
            .background(self.selected ? Color(red: 249/255, green: 228/255, blue: 209/255) : Color.white)
        })//: BUTTON
    }
}

struct CabinSegmentedView_Previews: PreviewProvider {
    static var previews: some View {
        CabinSegmentedView(cabinSelected: .constant("Premium"), name: "Premium")
    }
}
