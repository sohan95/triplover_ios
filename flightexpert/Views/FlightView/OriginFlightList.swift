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
                ForEach([2, 4, 6, 8, 10], id: \.self) { item in
                    HStack(spacing: 15) {
                        VStack{
                            RoundedRectangle(cornerRadius: 5)
                                        .fill(Color.gray)
                                        .frame(width: 80, height: 35)
                            Text("Aljazeera")
                                .font(.system(size: 14))
                        }
                        .frame(width: 100, height: 60)
                        
                        VStack{
                           Text("21:35")
                            Text("AMM")
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
                            Text("1 Stop").font(.system(size: 11))
                        }
                        VStack{
                            Text("21:35")
                            Text("AMM")
                        }
                        .frame(width:40)
                        .font(.system(size: 13))
                    }
                    Text(message)
                    
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
