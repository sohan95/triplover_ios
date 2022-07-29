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
            VStack(alignment: .leading, spacing:0) {
                Text(flight.paxName ?? "")
                    .font(.system(size: 11, weight: .medium, design: .rounded))
                    .padding(.bottom, 10)
                //getDateStringWithTemplate(dateStr:flight.issueDate ?? "", template: "yyyy-MM-dd'T'HH:mm:ss.SSS")
//                Text("Issue: \(getTimeString(dateStr:flight.issueDate!))")
//                Text("Depart: \(getTimeString(dateStr:flight.travellDate!))")
//                Text("Pnr: \(getTimeString(dateStr:flight.pnr!))")
//                Text("Status: \(getTimeString(dateStr:flight.status!))")
                
                Text("Issue: \(getDateStringWithTemplate(dateStr:flight.issueDate ?? "", template: "yyyy-MM-dd'T'HH:mm:ss.SSS"))")
                Text("Depart: \(flight.travellDate ?? "")")
                Text("Pnr: \(flight.pnr ?? "")")
                Text("Status: \(flight.status ?? "")")
            }
            .font(.system(size: 9, weight: .regular, design: .rounded))
            Spacer()
            Image(systemName: "chevron.right")
                .font(.system(size: 13, weight: .semibold, design: .rounded))
                .foregroundColor(.black)

        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.white)
                .shadow(color: .gray, radius: 1, x: 0, y: 1)
        )
        .padding(.horizontal,10)
        .onTapGesture {
            if let action = action {
                action(flight)
            }
        }
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
        
        VStack(alignment: .leading, spacing:0) {
            //:- Top
            VStack(alignment: .leading, spacing: 5) {
                HStack(alignment: .center) {
                    //Icon & Name
                    VStack(alignment: .center, spacing:0) {
                        ImageUrlView(urlString: "\(ROOT_URL_THUMB)\(direction.platingCarrierCode!).png",sizeVal: 50)
//                        .frame(minWidth: 50, maxWidth: .infinity)

                        Text(direction.platingCarrierName!)
                            .font(.system(size: 10, weight: .medium, design: .rounded))
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                    .frame(width: 110)
//                    .background(.gray)
//                    .padding(.leading, 5)
                    
//                    Spacer()
                    
                    //Transition
                    HStack(spacing:5) {
                        VStack(alignment: .leading, spacing: 5){
                            Text("\(getTimeString(dateStr: direction.segments?[0].details?[0].departure ?? ""))")
                            Text(direction.from!)
                        }
                        .frame(width:35)
//                        .background(.green)
                        .font(.system(size: 11, weight: .semibold, design: .rounded))
                        
                        VStack(alignment: .center, spacing: 0) {
                            HStack(alignment:.bottom, spacing: 10) {
                                Spacer()
                                Text("\(direction.segments?[0].details?[0].travelTime ?? "")")
                                    .font(.system(size: 9, weight: .medium, design: .rounded))
                                        .lineLimit(1)
                                        .padding(.trailing, 10)
                                Image(systemName: "airplane.departure")
                                    .foregroundColor(.red)
                                    .font(.system(size: 10, weight: .semibold, design: .rounded))
                            }
                            .frame(width: 100)
                            
                            HStack(spacing:0) {
                                Circle()
                                    .fill(.red)
                                    .frame(width: 8, height: 8)
                                    
                                RoundedRectangle(cornerRadius: 0.5)
                                            .fill(Color.red)
                                            .frame(width: 82, height: 1.5)
                            }
                            .frame(width: 90, height: 10)
                            
                            HStack(alignment:.top) {
                                if direction.stops == 0 {
                                    Text("No Stops").font(.system(size: 9, weight: .medium, design: .rounded))
                                } else {
                                    Text("direction.stop").font(.system(size: 9, weight: .medium, design: .rounded))
                                }
                            }
                            
                        }
//                        .background(.yellow)
                        
                        VStack {
                            Text("\(getTimeString(dateStr: direction.segments?[0].details?[0].arrival ?? ""))")
                            Text(direction.to!)
                        }
                        .frame(width:35)
//                        .background(.green)
                        .font(.system(size: 11, weight: .semibold, design: .rounded))
                    }
                    .frame(minWidth:0, maxWidth: .infinity)
//                    .background(.blue)
//                    .padding(.trailing, 5)
                    
                }
                .frame(minWidth:0, maxWidth: .infinity)
//                .background(.blue)
                
            }
            .frame(minWidth:0, maxWidth: .infinity, minHeight:80,maxHeight: 80)
//            .background(.red)
            .padding(.horizontal,5)
            
            
            //Spacer()
            //:- Bottom
            HStack {
                VStack(alignment: .leading, spacing: 5){
                    HStack(spacing: 5){
                        Text("BDT")
                        Text("\((direction.bookingComponents?[0].basePrice)!.removeZerosFromEnd())")
                            .foregroundColor(.red.opacity(0.7))
                    }
                    .font(.system(size: 11, weight: .bold, design: .rounded))
                    
                    Text("Refundable")
                        .font(.system(size: 11, weight: .medium, design: .rounded))
                        .foregroundColor(.yellow.opacity(0.8))
                }
                Spacer()
                HStack {
                    Button {
                        FlightDetailsAction()
                    } label: {
                        Text("Flight Details")
                            .underline()
                            .font(.system(size: 11, weight: .medium, design: .rounded))
                    }
                    
                    Button {
                        FlightSelectAction()
                    } label: {
                        Text("Select")
                            .padding(.horizontal, 5)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(selectedDirection?.id == direction.id ? .blue : .orange)
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                }
            }
            .padding(10)
            .frame(minWidth:0, maxWidth: .infinity, minHeight:50,maxHeight: 50)
            .background(RoundedCorners(color: Color("LightGray").opacity(0.3), tl: 0, tr: 0, bl: 5, br: 5))
        }
        .frame(minWidth:0, maxWidth: .infinity, minHeight:130,maxHeight: 130)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.white)
                .shadow(color: .gray.opacity(0.5), radius: 2, x: 0, y: 2)
        )
        .padding(.horizontal,5)
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

struct RoundedCorners: View {
    var color: Color = .blue
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                
                let w = geometry.size.width
                let h = geometry.size.height

                // Make sure we do not exceed the size of the rectangle
                let tr = min(min(self.tr, h/2), w/2)
                let tl = min(min(self.tl, h/2), w/2)
                let bl = min(min(self.bl, h/2), w/2)
                let br = min(min(self.br, h/2), w/2)
                
                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                path.addLine(to: CGPoint(x: bl, y: h))
                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
                path.closeSubpath()
            }
            .fill(self.color)
        }
    }
}



