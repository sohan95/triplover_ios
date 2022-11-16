//
//  RadioRouteGroupBotton.swift
//  flightexpert
//
//  Created by sohan on 6/22/22.
//

import SwiftUI




//MARK:- Group of Radio Buttons
enum RouteType: String {
    case oneWay = "One-Way"
    case roundTrip = "Round-Trip"
    case multiCity = "Multi-City"
}

struct RadioRouteGroupBotton: View {
    
    var selectedId: String
    
    let callback: (String) -> ()
    
    var body: some View {
        HStack(alignment: .center, spacing: 5) {
            radioOneWay
            radioRound
            radioMultiCity
        }
//        .background(.gray)
    }
    
    var radioOneWay: some View {
        RadioButtonView(
            id: RouteType.oneWay.rawValue,
            label: RouteType.oneWay.rawValue,
            isMarked: selectedId == RouteType.oneWay.rawValue ? true : false,
            callback: radioGroupCallback
        )
    }
    
    var radioRound: some View {
        RadioButtonView(
            id: RouteType.roundTrip.rawValue,
            label: RouteType.roundTrip.rawValue,
            isMarked: selectedId == RouteType.roundTrip.rawValue ? true : false,
            callback: radioGroupCallback
        )
    }
    
    var radioMultiCity: some View {
        RadioButtonView(
            id: RouteType.multiCity.rawValue,
            label: RouteType.multiCity.rawValue,
            isMarked: selectedId == RouteType.multiCity.rawValue ? true : false,
            callback: radioGroupCallback
        )
    }
    
    func radioGroupCallback(id: String) {
        if selectedId != id {
            // selectedId = id
            callback(id)
        }
    }
}

struct RadioRouteGroupBotton_Previews: PreviewProvider {
    static var previews: some View {
        RadioRouteGroupBotton(selectedId: "One-Way") { abc in
            //
        }
    }
}
