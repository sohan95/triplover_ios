//
//  RadioRouteGroupBotton.swift
//  flightexpert
//
//  Created by sohan on 6/22/22.
//

import SwiftUI

//MARK:- Single Radio Button Field
struct RadioButtonField: View {
    let id: String
    let label: String
    let size: CGFloat
    let color: Color
    let textSize: CGFloat
    let isMarked:Bool
    let callback: (String)->()
    
    init(
        id: String,
        label:String,
        size: CGFloat = 15,
        color: Color = Color.white,
        textSize: CGFloat = 9,
        isMarked: Bool = false,
        callback: @escaping (String)->()
        ) {
        self.id = id
        self.label = label
        self.size = size
        self.color = color
        self.textSize = textSize
        self.isMarked = isMarked
        self.callback = callback
    }
    
    var body: some View {
        Button(action:{
            self.callback(self.id)
        }) {
            HStack(alignment: .center, spacing: 5) {
                Image(systemName: "circle.inset.filled")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                    .foregroundColor(self.isMarked ? Color("title_third") : self.color)
                Text(label)
                    .font(Font.system(size: textSize, weight: .bold, design: .rounded))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                    .foregroundColor(self.color)
                Spacer()
            }
            .padding(.horizontal, 5)
            .padding(.vertical, 8)
            
        }
        .background(
            RoundedRectangle(cornerRadius: 5).fill(Color("colorPrimary"))
        )
    }
}

struct RadioButtonField_Previews: PreviewProvider {
    static var previews: some View {
        RadioButtonField(id: "ABCD", label: "ABCD") { nAME in
            //
        }
    }
}


//MARK:- Group of Radio Buttons
enum RouteType: String {
    case oneWay = "One-Way"
    case roundTrip = "Round-Trip"
    case multiCity = "Multi-City"
}

struct RadioRouteGroupBotton: View {
    
    @Binding var selectedId: String
    
    let callback: (String) -> ()
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            radioOneWay
            radioRound
            radioMultiCity
        }
    }
    
    var radioOneWay: some View {
        RadioButtonField(
            id: RouteType.oneWay.rawValue,
            label: RouteType.oneWay.rawValue,
            isMarked: selectedId == RouteType.oneWay.rawValue ? true : false,
            callback: radioGroupCallback
        )
    }
    
    var radioRound: some View {
        RadioButtonField(
            id: RouteType.roundTrip.rawValue,
            label: RouteType.roundTrip.rawValue,
            isMarked: selectedId == RouteType.roundTrip.rawValue ? true : false,
            callback: radioGroupCallback
        )
    }
    
    var radioMultiCity: some View {
        RadioButtonField(
            id: RouteType.multiCity.rawValue,
            label: RouteType.multiCity.rawValue,
            isMarked: selectedId == RouteType.multiCity.rawValue ? true : false,
            callback: radioGroupCallback
        )
    }
    
    func radioGroupCallback(id: String) {
        if selectedId != id {
            selectedId = id
            callback(id)
        }
    }
}

//struct RadioRouteGroupBotton_Previews: PreviewProvider {
//    static var previews: some View {
//        RadioRouteGroupBotton((selectedId: "Round", callback: ("Round") -> ()))
//    }
//}
