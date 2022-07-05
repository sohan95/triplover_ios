//
//  ListRow.swift
//  flightexpert
//
//  Created by sohan on 6/3/22.
//

import SwiftUI

struct ListRow: View {
    typealias Action = (Direction) -> Void
    
//    @State var selectedModel: RandomModel? = nil
    @State var direction: Direction
    @Binding var isSelectBtnTapped: Bool
    var action: Action?
    
//    @ObservedObject var flightSearchModel: FlightSearchModel()
//    var selectedDirection: Direction
    var body: some View {
        
        VStack(alignment: .leading, spacing:10) {
            //:- Top
            HStack(spacing: 20) {
                VStack {
                    
                    AsyncImage(
                        url:  URL(string: "\(ROOT_URL_THUMB)\(direction.platingCarrierCode!).png"),
                        transaction: Transaction(animation: .easeInOut)
                    ) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .transition(.scale(scale: 0.1, anchor: .center))
                        case .failure:
                            Image(systemName: "wifi.slash")
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(width: 40, height: 40)
                    .background(Color.gray)
                    .clipShape(Circle())

//                    Text("Bangladesh Biman")
//                        .font(.system(size: 12))
                    Text(direction.platingCarrierName!)
                        .font(.system(size: 12))
                }
                .frame( height: 60)
                Spacer()
                
                VStack{
//                    Text("21:35")
                    Text("\(getTimeString(dateStr: direction.segments?[0].details?[0].departure ?? ""))")
//                    Text("DAC")
                    Text(direction.from!)
                }
                .frame(width:40)
                .font(.system(size: 12))
                
                VStack {
                    HStack {
                        //Text("9 Hrs : 50 Mins").font(.system(size: 8))
                         //   .lineLimit(1)
                        Text("\(direction.segments?[0].details?[0].travelTime ?? "")")
                            .font(.system(size: 8))
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
                    //Text("No Stops").font(.system(size: 11))
                    if direction.stops == 0 {
                        Text("No Stops").font(.system(size: 11))
                    } else {
                        Text("direction.stop").font(.system(size: 11))
                    }
                    
                }
                VStack {
//                    Text("21:35")
                    //Text("CTT")
                    Text("\(getTimeString(dateStr: direction.segments?[0].details?[0].arrival ?? ""))")
                    Text(direction.to!)
                }
                .frame(width:40)
                .font(.system(size: 13))
            }
            
            //:- Bottom
            HStack {
                VStack{
                    HStack{
                        Text("BDT")
                        //Text("3335")
                        Text(": \((direction.bookingComponents?[0].basePrice)!.removeZerosFromEnd())")
                            
                    }
                    .font(.system(size: 14, weight: .medium))
                    Text("Refundable")
                        .font(.system(size: 14, weight: .medium))
                }
                Spacer()
                HStack {
                    Button {
                        FlightDetailsAction()
                    } label: {
                        Text("Flight Details")
                            .underline()
                            .font(.system(size: 12, weight: .bold))
                    }
                    
                    Button {
                        FlightSelectAction()
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
    
    func FlightDetailsAction() {
//        selectedModel = RandomModel(title:"Details", iata:direction.from!)
        if let action = action {
            isSelectBtnTapped = false
//            selectedDirection?.isSelected = false
            action(direction)
        }
    }
    
    func FlightSelectAction() {
        
//        selectedModel = RandomModel(title:"Select", iata:direction.from!)
        if let action = action {
            isSelectBtnTapped = true
            action(direction)
        }
        
    }
    
    func getTimeString(dateStr: String) -> String {
//        let string = "2022-07-30 18:00:00"

        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateStr)!
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: date)
        print("EXACT_DATE : \(dateString)")
        return dateString
    }
    
    func getDateFromString(dateStr: String) -> Date {
//        let isoDate = "2016-04-14T10:44:00+0000"
//
//          let dateFormatter = DateFormatter()
//          dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
//          dateFormatter.dateFormat = "h:mm a"
//          let date = dateFormatter.date(from:isoDate)!
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.date(from: dateStr)!
    }
    
}

//struct ListRow_Previews: PreviewProvider {
//    static var previews: some View {
////        let dir = try? Direction(from: "Dhaka" as! Decoder)
////        ListRow(direction: .constant(dir), isSelectBtnTapped: true)
//    }
//}



