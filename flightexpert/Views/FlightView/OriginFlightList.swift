//
//  OriginFlightList.swift
//  flightexpert
//
//  Created by sohan on 6/1/22.
//

import SwiftUI

struct OriginFlightList: View {
    var title:String
    @ObservedObject var flightSearchModel: FlightSearchModel
    @State private var sheetMode: SheetMode = .half
    
    @State private var selectedDirectoin: Direction? = nil
    
    var body: some View {
        
        ZStack {
            backgroundGradient
                .ignoresSafeArea(.all, edges: .all)
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(flightSearchModel.forwardDirections, id: \.self) {direction in
//                        ListRow(direction: direction) {direction in
//                            print(direction)
//                        }
                        ListRow(direction: direction, selectedDirection: $selectedDirectoin) { directionResult in
                            
                            selectOriginFlight(direction: directionResult)
                            //selectedDirectoin = directionResult
                            print(selectedDirectoin!)
                            sheetMode = .half
                        }
                    }
                }
            }
            .onAppear() {
                flightSearchModel.getForwardDirection()
            }
            .onTapGesture {
                sheetMode = .none
            }
            
            FlexibleSheet(sheetMode: $sheetMode) {
                ZStack {
                    backgroundGradient
                        .ignoresSafeArea()
                    if let selected = self.selectedDirectoin {
                        VStack(spacing:10) {
                            HStack(spacing: 10) {
                                Button("Bag Details"){
                                    print("Show Bag Details")
                                }.foregroundColor(.white)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                Divider()
                                    .frame(width: 1, height: 20, alignment: .bottom)
                                    .background(.white)
                                Button("Price Details"){
                                    print("Show Price Details")
                                }.foregroundColor(.white)
                                    
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                
                                Divider()
                                    .frame(width: 1, height: 20, alignment: .bottom)
                                    .background(.white)
                                
                                Button("Confirm") {
                                    //print("Confirm")
                                }.frame(minWidth: 0, maxWidth: .infinity)
                            }
                            .frame(maxWidth:.infinity, maxHeight:20)
    //                        .background(.blue)
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .bold))
                            .padding(10)
                            
                            VStack {
                                VStack(spacing: 20){
                                    Spacer()
                                    HStack {
                                        Image(systemName: "airplane")
                                            .resizable()
                                            .frame(width: CGFloat(30), height: CGFloat(30), alignment: .center)
                                    }
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .background(.secondary)
                                    
                                    Spacer()
                                    HStack(alignment:.bottom, spacing: 10) {
                                        VStack(alignment: .leading) {
                                            //
                                            Text(selected.platingCarrierName!)
                                            Text("\(selected.platingCarrierCode!)-\(selected.segments?[0].flightNumber ?? ""), \(selected.segments?[0].serviceClass ?? "")")
                                        }
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        .background(.secondary)
                                        Divider()
                                            .frame(width: 1, height: 40, alignment: .center)
                                            .background(.black)
                                        VStack(alignment: .leading) {
                                            Text("\(selected.from!) - \(selected.to!)")
                                            Text("\(selected.segments?[0].details?[0].travelTime ?? "")")
                                        }
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        .background(.secondary)
                                    }
                                    .padding(10)
                                    
                                }
                                .frame(maxWidth:.infinity)
                                .frame(height:150)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 5.0))
                                .padding(10)
                                
                                HStack{
                                    
                                    VStack(alignment: .leading){
                                        Text("\(selected.segments?[0].details?[0].departure ?? "")")
                                        Text("2022-06-06")
                                        Text("[\(selected.from!)]")
                                        Text("Terminal:\(selected.fromAirport!)")
                                    }
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    VStack(alignment: .leading){
                                        Text("\(selected.segments?[0].details?[0].arrival ?? "")")
                                        Text("2022-06-06")
                                        Text("[\(selected.to!)]")
                                        Text("Terminal:\(selected.toAirport!)")
                                            
                                    }
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    
                                }
                                .foregroundColor(Color.white)
                                .padding(10)
                                Spacer()
                            }
                            .frame(maxWidth:.infinity, maxHeight: 280)
                            .padding(.bottom,10)
                            .background(.secondary)
                            Spacer()
                        }
                        .padding(.horizontal, 10)
                        .background(.secondary)
                    }
                }
                
            }
            
//            FlexibleSheet(sheetMode: $sheetMode) {
//                VStack {
//                    if let selected = selected {
//                        Text(selected.id)
//                            .foregroundColor(.red)
//                    }
//                    if let selected = selected {
//                        Text(selected.segments?[0].departure! ?? "")
//                            .foregroundColor(.red)
//                    }
//                    if let selected = selected {
//                        Text(selected.segments?[0].airline! ?? "")
//                            .foregroundColor(.red)
//                    }
//                    Text("RED Color")
//                        .foregroundColor(.red)
//                    Text("RED Color")
//                        .foregroundColor(.red)
//                    Spacer()
//                }
//                .frame(maxWidth:.infinity, maxHeight: .infinity)
//                .background(.gray)
//                .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
//            }
            
            
            //
        }
        
    }
    
    func selectOriginFlight(direction: Direction) {
        flightSearchModel.setOrigin(direction: direction)
    }
}

struct OriginFlightList_Previews: PreviewProvider {
    static var previews: some View {
       // OriginFlightList(
        OriginFlightList(title: "Source", flightSearchModel: FlightSearchModel())
    }
}

//struct DestinFlightList: View {
//    var title:String
//    @ObservedObject var flightSearchModel: FlightSearchModel
//
//    var body: some View {
//
//        ZStack {
//            backgroundGradient
//                .ignoresSafeArea(.all, edges: .all)
//
//            ScrollView {
//                VStack(spacing: 20) {
//                    ForEach(flightSearchModel.forwardDirections, id: \.self) {direction in
//                        ListRow(direction: direction) { direction in
//                            selectDestinationFlight(direction: direction)
//                        }
//                    }
//                }
//            }
//            .onAppear() {
//                flightSearchModel.getForwardDirection()
//            }
//        }
//    }
//
//    func selectDestinationFlight(direction: Direction) {
//        flightSearchModel.setDestination(direction: direction)
//    }
//}

