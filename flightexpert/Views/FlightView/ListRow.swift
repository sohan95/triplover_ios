//
//  ListRow.swift
//  flightexpert
//
//  Created by sohan on 6/3/22.
//

import SwiftUI

struct ListRow: View {
    typealias Action = (Direction) -> Void
    
    @State var selectedModel: RandomModel? = nil
    @State var direction: Direction
    @Binding var selectedDirection: Direction?
    var action: Action?
    
//    @ObservedObject var flightSearchModel: FlightSearchModel()
//    var selectedDirection: Direction
    var body: some View {
        
        VStack(alignment: .leading, spacing:10) {
            //:- Top
            HStack(spacing: 20) {
                VStack {
                    Image("biman-bd-icon")
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)
                        .frame(width: 40)

                    Text("Bangladesh Biman")
                        .font(.system(size: 12))
                    //Text(direction.platingCarrierName!)
                        .font(.system(size: 14))
                }
                .frame( height: 60)
                Spacer()
                
                VStack{
                    Text("21:35")
                    Text("DAC")
                    //Text(direction.from!)
                }
                .frame(width:40)
                .font(.system(size: 12))
                
                VStack {
                    HStack {
                        Text("9 Hrs : 50 Mins").font(.system(size: 8))
                            .lineLimit(1)
                        Image(systemName: "airplane.departure")
                            .foregroundColor(.red)
                    }
                    .frame(width:100)
                    HStack(spacing:0) {
                        Circle()
                            .fill(.red)
                            .frame(width: 10, height: 10)
                            
                        RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.red)
                                    .frame(width: 100, height: 2)
                    }
                    .frame(height:10)
                    
                    
                    Text("No Stops").font(.system(size: 11))
    //                            if direction.stops == 0 {
    //                                Text("No Stops").font(.system(size: 11))
    //                            } else {
    //                                Text("direction.stop").font(.system(size: 11))
    //                            }
                    
                }
                VStack {
                    Text("21:35")
                    Text("CTT")//Text(direction.to!)
                }
                .frame(width:40)
                .font(.system(size: 13))
            }
            
            //:- Bottom
            HStack {
                VStack{
                    HStack{
                        Text("BDT")
                        Text("3335")
                    }
                    Text("Refundable")
                }
                Spacer()
                HStack {
                    Button {
                        selectedModel = RandomModel(title:"Details", iata:direction.from!)
                        if let action = action {
                            selectedDirection = direction
                            selectedDirection?.isSelected = false
                            action(selectedDirection!)
                        }
                    } label: {
                        Text("Flight Details")
                            .underline()
                            .font(.system(size: 12, weight: .bold))
                    }
                    
                    Button {
                        selectedModel = RandomModel(title:"Select", iata:direction.from!)
                        if let action = action {
                            selectedDirection = direction
                            selectedDirection?.isSelected = true
                            print("changed direction=\(self.direction)")
                            action(selectedDirection!)
                        }
                        
                    } label: {
                        Text("Select")
                            .padding(.horizontal,10)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                    .font(.system(size: 14, weight:.heavy))
                    
                    

                }
//                .sheet(item: $selectedModel) { model in
//                    
////                    if let action = action {
////                        action(direction)
////                    }
////                    FlightDetailsView<<#Content: View#>>(selectedModel: model, selectedDirection: direction) { direction in
////                        if (selectedModel?.title == "Details") {
////                            print("Mode=\(String(describing: selectedModel?.title))")
////                        } else if (selectedModel?.title == "Select") {
////                            print("Mode=\(String(describing: selectedModel?.title))")
////                            if let action = action {
////                                action(direction)
////                            }
////                        }
////                    }
//                    
//                }
            }
            .background(Color("LightGray"))
        }
//        .foreground//Color(.white)
        .padding()
        .background(Color.white.cornerRadius(10))
        //.padding(.horizontal)
    }
    
}

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        let dir = try? Direction(from: "Dhaka" as! Decoder)
       // ListRow(direction: .contains(dir))
    }
}



