//
//  CustomerCountView.swift
//  flightexpert
//
//  Created by sohan on 6/21/22.
//

import SwiftUI

struct CustomerCountView: View {
    var title: String
    @Binding var customerCount: Int
    var maxNumber: Int
    
    typealias Action = (Int) -> Void
    var action: Action?
    
    var body: some View {
        
        VStack(spacing:20) {
            HStack{
                Button {
                    if customerCount < maxNumber {
                        customerCount += 1
                        if let action = action {
                            action(customerCount)
                        }
                    }
                } label: {
                    Image(systemName: "plus.square")
                        .resizable()
                        .frame(width: 25,height: 25)
                    
                }.foregroundColor(.black)
                
                Text("\(customerCount)")
                
                Button {
                    if customerCount > 0 {
                        customerCount -= 1
                    }
                    if let action = action {
                        action(customerCount)
                    }
                } label: {
                    Image(systemName: "minus.square")
                        .resizable()
                        .frame(width: 25,height: 25)
                    
                }.foregroundColor(.black)
                
            }
            Text("\(title)(\(customerCount)+)")
                .frame(width: 100)
        }
        .padding(20)
        .frame(width: 130)
    }
}

struct CustomerCountView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerCountView(title: "Adults", customerCount: .constant(1), maxNumber: 8)
    }
}
