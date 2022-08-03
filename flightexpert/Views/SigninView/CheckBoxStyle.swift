//
//  CheckBoxStyle.swift
//  flightexpert
//
//  Created by sohan on 5/16/22.
//

import Foundation
import SwiftUI

struct CheckboxStyle: ToggleStyle {
 
    func makeBody(configuration: Self.Configuration) -> some View {
 
        return HStack {
 
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 15, height: 15)
                .foregroundColor(configuration.isOn ? Color("button-bg-color") : .gray)
                .font(.system(size: 11, weight: .medium, design: .default))
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            
            configuration.label
 
            Spacer()
        }
 
    }
}
