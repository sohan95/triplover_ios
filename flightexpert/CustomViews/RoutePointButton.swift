//
//  RoutePointButton.swift
//  flightexpert
//
//  Created by sohan on 7/27/22.
//

import SwiftUI

struct RoutePointButton: View {
    @State var selectedModel: RandomModel? = nil
    @Binding var source: AirportData
    
    var body: some View {
        Button {
            selectedModel = RandomModel(title:"source", iata: source.iata)
        } label: {
            VStack(alignment:.leading, spacing: 5){
                Text("From")
                    .font(.system(size: 11, weight: .medium, design: .rounded))
                Text(source.iata)
                    .font(.system(size: 13, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                Text("Click to search")
                    .font(.system(size: 10, weight: .regular, design: .rounded))
            }
            .foregroundColor(Color(hex: "#2D2D2D"))
            .padding(2)
        }
        .frame(minWidth:0, maxWidth: .infinity, minHeight: 75, maxHeight: 75, alignment: .leading)
        .padding(.leading, 10)
        .background(.white)
        .addBorder(Color.gray, width: 0.7, cornerRadius: 5)
        .sheet(item: $selectedModel) { model in
            AirportList() { airport in
                source = airport
                print("source=\(airport)")
            }
        }
    }
}

struct RoutePointButton_Previews: PreviewProvider {
    static var previews: some View {
        let source = AirportData(name: "Aasiaat", city: "Aasiaat", country:"Greenland", iata: "JEG")
        RoutePointButton(source: .constant(source))
    }
}