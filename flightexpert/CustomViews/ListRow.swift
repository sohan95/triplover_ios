//
//  ListRow.swift
//  flightexpert
//
//  Created by sohan on 6/3/22.
//

import SwiftUI

struct BookedFlight: View {
    typealias Action = (AirTicketingResponse) -> Void
    @State var flight: AirTicketingResponse
    var action: Action?
    
    var body: some View {
        
        HStack {
            
            VStack(alignment: .leading, spacing:5) {
                Text(flight.paxName!)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .padding(.bottom, 10)
                //getDateStringWithTemplate(dateStr:flight.issueDate ?? "", template: "yyyy-MM-dd'T'HH:mm:ss.SSS")
//                Text("Issue: \(getTimeString(dateStr:flight.issueDate!))")
//                Text("Depart: \(getTimeString(dateStr:flight.travellDate!))")
//                Text("Pnr: \(getTimeString(dateStr:flight.pnr!))")
//                Text("Status: \(getTimeString(dateStr:flight.status!))")
                
                Text("Issue: \(getDateStringWithTemplate(dateStr:flight.issueDate ?? "", template: "yyyy-MM-dd'T'HH:mm:ss.SSS"))")
                Text("Depart: \(flight.travellDate!)")
                Text("Pnr: \(flight.pnr!)")
                Text("Status: \(flight.status!)")
            }
            .font(.system(size: 13, weight: .semibold, design: .rounded))
            Spacer()
            Button {
                if let action = action {
                    action(flight)
                }
            } label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
            }

        }
        .frame(maxWidth:.infinity)
        .padding()
        .background(Color.white.cornerRadius(10))
        .padding(.horizontal,20)
    }
}

struct ListRow: View {
    typealias Action = (Direction) -> Void
    
//    @State var selectedModel: RandomModel? = nil
    @State var direction: Direction
    @Binding var isSelectBtnTapped: Bool
    var selectedDirection: Direction? = nil
    var action: Action?
    
//    @ObservedObject var flightSearchModel: FlightSearchModel()
//    var selectedDirection: Direction
    var body: some View {
        
        VStack(alignment: .leading, spacing:10) {
            //:- Top
            HStack(spacing: 20) {
                VStack {
                    ImageUrlView(urlString: "\(ROOT_URL_THUMB)\(direction.platingCarrierCode!).png")
                    .frame(width: 40, height: 40)
                    .scaledToFit()
//                    .background(Color.gray)
//                    .clipShape(Circle())
                    Text(direction.platingCarrierName!)
                        .font(.system(size: 12))
                }
                .frame( height: 60)
                Spacer()
                
                VStack{
                    Text("\(getTimeString(dateStr: direction.segments?[0].details?[0].departure ?? ""))")
                    Text(direction.from!)
                }
                .frame(width:40)
                .font(.system(size: 12))
                
                VStack {
                    HStack {
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
                    if direction.stops == 0 {
                        Text("No Stops").font(.system(size: 11))
                    } else {
                        Text("direction.stop").font(.system(size: 11))
                    }
                    
                }
                VStack {
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
                    .tint(selectedDirection?.id == direction.id ? .blue : .orange)
                    .font(.system(size: 14, weight:.heavy))
                }
            }
//            Spacer()
//            .background(Color("LightGray"))
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
    
//    func getTimeString(dateStr: String) -> String {
////        let string = "2022-07-30 18:00:00"
//
//        let dateFormatter = DateFormatter()
//        let tempLocale = dateFormatter.locale // save locale temporarily
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let date = dateFormatter.date(from: dateStr)!
//        dateFormatter.dateFormat = "HH:mm"
//        dateFormatter.locale = tempLocale // reset the locale
//        let dateString = dateFormatter.string(from: date)
//        print("EXACT_DATE : \(dateString)")
//        return dateString
//    }
    
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

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
//        let dir = try? Direction(from: "Dhaka" as! Decoder)
//        ListRow(direction: .constant(Direction()), isSelectBtnTapped: true)
//        OriginFlightList(title: "abc", flightSearchModel: FlightSearchModel())
        ZStack {
            Color.gray
            BookedFlight(flight: AirTicketingResponse(paxName: "Rafiur Rahamn", issueDate: "25-5-87", travellDate: "25-5-87", uniqueTransID: "25-5-87", pnr: "25-5-87", ticketNumber: "25-5-87", status: "25-5-87", platingCarrier: "25-5-87", airlineName: "25-5-87", origin: "25-5-87", destination: "25-5-87", journeyType: "25-5-87", gatewayCharge: 12.0))
        }
        
    }
}



