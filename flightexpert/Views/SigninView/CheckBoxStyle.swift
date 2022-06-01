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
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? .green : .gray)
                .font(.system(size: 20, weight: .bold, design: .default))
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            
            configuration.label
 
            Spacer()
        }
 
    }
}
