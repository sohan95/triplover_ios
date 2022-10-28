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
                .frame(width: 20, height: 20)
                .foregroundColor(configuration.isOn ? Color("button-bg-color") : .black.opacity(0.7))
                .font(.system(size: 13, weight: .medium, design: .default))
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            
            configuration.label
 
            Spacer()
        }
 
    }
}
