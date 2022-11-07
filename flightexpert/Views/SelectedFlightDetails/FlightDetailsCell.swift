//
//  FlightDetailsCell.swift
//  flightexpert
//
//  Created by sohan on 7/5/22.
//

import SwiftUI

struct FlightDetailsCell: View {
    var direction: Direction
    
    var body: some View {
        
        HStack {
            VStack(alignment:.leading, spacing:10) {
                HStack(spacing: 20) {
                    Image(systemName: "airplane.departure")
                    Text("\(direction.from!) - \(direction.to!)")
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                }
                .foregroundColor(.blue)
                .padding(.bottom, 10)
                HStack(spacing: 20) {
                    ImageUrlView(urlString: "\(ROOT_URL_THUMB)\(direction.platingCarrierCode!).png", sizeVal: 20)
                        .frame(width: 20, height: 20)
                        .clipShape(Circle())
                    VStack(alignment: .leading, spacing: 2){
                        Text("\(direction.segments?[0].details?[0].departure ?? "")")
                        Text("\(direction.fromAirport!)")
                    }
                }
                HStack(spacing: 20) {
                    Image(systemName: "airplane.departure")
                        .foregroundColor(.gray)
                    Text("\(direction.segments?[0].serviceClass ?? "")")
                }
                HStack(spacing: 20) {
                    Image(systemName: "person")
                        .foregroundColor(.gray)
                    Text("\(direction.platingCarrierCode!)-\(direction.segments?[0].flightNumber ?? "")")
                }
                HStack(spacing: 20) {
                    Image(systemName: "clock")
                        .foregroundColor(.gray)
                    Text("\(direction.segments?[0].details?[0].travelTime ?? "")")
                }
                HStack(spacing: 20) {
                    Image(systemName: "airplane.arrival")
                        .foregroundColor(.gray)
                    VStack(alignment: .leading, spacing: 2){
                        Text("\(direction.segments?[0].details?[0].arrival ?? "")")
                        Text("\(direction.toAirport!)")
                    }
                }
                HStack(spacing: 20) {
                    Image(systemName: "airplane.departure")
                        .foregroundColor(.gray)
                    if let baggage = direction.segments?.first?.baggage?.first {
                        Text("\((baggage.amount)!.removeZerosFromEnd()) - \((baggage.units)!)")
                    }
                }
                
            }
            .font(.system(size: 13, weight: .regular, design: .rounded))
            .foregroundColor(.black)
            .background(.white)
            .padding(20)
            Spacer()
        }
        .background(.white)
        .cornerRadius(10)
        .padding(.horizontal, 10)
    }
}

//struct FlightDetailsCell_Previews: PreviewProvider {
//    static var previews: some View {
////        FlightDetailsCell()
//    }
//}
////
///
//VStack(alignment:.leading, spacing: 10) {
//    VStack(alignment:.leading, spacing:10) {
//        HStack(spacing: 15) {
//            Image(systemName: "airplane.departure")
//            Text("\(selected.from!) - \(selected.to!)")
//        }
//        .foregroundColor(.blue)
//        .padding(.bottom, 10)
//        HStack(spacing: 15) {
//            Image(systemName: "airplane.departure")
//                .foregroundColor(.red)
//            VStack{
//                Text("\(selected.segments?[0].details?[0].departure ?? "")")
//                Text("\(selected.fromAirport!)")
//            }
//        }
//        HStack(spacing: 15) {
//            Image(systemName: "airplane.departure")
//                .foregroundColor(.gray)
//            Text("\(selected.segments?[0].serviceClass ?? "")")
//        }
//        HStack(spacing: 15) {
//            Image(systemName: "airplane.departure")
//                .foregroundColor(.gray)
//            Text("\(selected.platingCarrierCode!)-\(selected.segments?[0].flightNumber ?? "")")
//        }
//        HStack(spacing: 15) {
//            Image(systemName: "clock")
//                .foregroundColor(.gray)
//            Text("\(selected.segments?[0].details?[0].travelTime ?? "")")
//        }
//        HStack(spacing: 15) {
//            Image(systemName: "airplane.departure")
//                .foregroundColor(.gray)
//            VStack{
//                Text("\(selected.segments?[0].details?[0].arrival ?? "")")
//                Text("\(selected.toAirport!)")
//            }
//        }
//        HStack(spacing: 15) {
//            Image(systemName: "airplane.departure")
//                .foregroundColor(.gray)
//            Text("\((selected.segments?[0].baggage?[0].amount)!.removeZerosFromEnd()) - \((selected.segments?[0].baggage?[0].units)!)")
//        }
//
//    }
//    .frame(maxWidth:.infinity, minHeight: 250,maxHeight: 250)
//    .foregroundColor(.black)
//}
//.font(.system(size: 13, weight: .medium, design: .rounded))
//.background(.white)
//.cornerRadius(10)
//.padding(.horizontal, 20)
////

//                VStack() {
//                    VStack {
//                        Label("CGP - DAC", systemImage: "folder.circle")
//                        Label("\(selected.from!) - \(selected.to!)", systemImage: "folder.circle")
//                        Label("\(selected.from!) - \(selected.to!)", systemImage: "folder.circle")
//                        Label("\(selected.from!) - \(selected.to!)", systemImage: "folder.circle")
//                        Label("\(selected.from!) - \(selected.to!)", systemImage: "folder.circle")
//                    }
//                    Text("\(selected.from!) - \(selected.to!)")
//                    Text("\(selected.segments?[0].details?[0].travelTime ?? "")")
//                }
/*
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
        Button {
            ConfirmAction()
        } label: {
            if flightSearchModel.isSelectBtnTapped {
                Text("Confirm")
                    .frame(width:50)
            } else {
                Text("Cancel")
                    .frame(width:50)
            }
            
                
        }.frame(minWidth: 0, maxWidth: .infinity)
    }
    .frame(maxWidth:.infinity, maxHeight:20)
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
}
 */
