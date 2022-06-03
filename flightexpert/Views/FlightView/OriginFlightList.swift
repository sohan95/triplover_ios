//
//  OriginFlightList.swift
//  flightexpert
//
//  Created by sohan on 6/1/22.
//

import SwiftUI

struct OriginFlightList: View {
    var message:String
    var directionList:[Directions]
    
    var body: some View {
        ZStack{
            List {
                ForEach(directionList, id: \.self) { direction in
                    HStack(spacing: 15) {
                        VStack{
                            RoundedRectangle(cornerRadius: 5)
                                        .fill(Color.gray)
                                        .frame(width: 80, height: 35)
                            Text(direction.platingCarrierName!)
                                .font(.system(size: 14))
                        }
                        .frame(width: 100, height: 60)
                        
                        VStack{
                           Text("21:35")
                            Text(direction.from!)
                        }
                        .frame(width:40)
                        .font(.system(size: 12))
                        
                        VStack{
                            HStack {
                                Text("9 Hrs : 50 Mins").font(.system(size: 8))
                                    .lineLimit(1)
                                Image(systemName: "airplane.departure")
                            }
                            .frame(width:100)
                            
                            RoundedRectangle(cornerRadius: 5)
                                        .fill(Color.gray)
                                        .frame(width: 100, height: 2)
                            if direction.stops == 0 {
                                Text("No Stops").font(.system(size: 11))
                            } else {
                                Text("direction.stop").font(.system(size: 11))
                            }
                            
                        }
                        VStack{
                            Text("21:35")
                            Text(direction.to!)
                        }
                        .frame(width:40)
                        .font(.system(size: 13))
                    }
                    
                }
                .background(.white)
            
            }
            .background(.red)
            
        }
    }
}

struct OriginFlightList_Previews: PreviewProvider {
    static var previews: some View {
        OriginFlightList(message: "Bangladesh", directionList: [])
    }
}
