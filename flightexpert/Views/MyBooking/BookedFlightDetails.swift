//
//  BookedFlightDetails.swift
//  flightexpert
//
//  Created by sohan on 7/9/22.
//

import SwiftUI



struct BookedFlightDetails: View {
    var selectedBookedFlight: AirTicketingResponse? = nil
    
    @State var airTicketingDetails: AirTicketingDetailsResponse? = nil
    @State var isLoading:Bool = true
    @State var showErrorAlert = false
    
    @Environment(\.presentationMode) var presentationMode
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
            Image(systemName: "arrow.backward") // set image here
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.black)
            }
        }
    }
    
    var body: some View {
        ZStack {
            if !isLoading {
                if let details = airTicketingDetails {
                    VStack {
                        HStack{
                            Image("app_name_header")
                            Spacer()
                        }
                        .padding(.bottom,20)
                        VStack(alignment:.leading, spacing: 10) {
                            HStack(spacing:5){
                                Text("Issue Date:")
                                    .font(.system(size: 10, weight: .medium, design: .rounded))
                                Text("\(getDateStringWithTemplate(dateStr:details.issueDate ?? "", template: "yyyy-MM-dd'T'HH:mm:ss.SSS"))")
                                    .font(.system(size: 10, weight: .bold, design: .rounded))
                                
                                Spacer()
                            }
                            PassengerInfo(ticketInfoes:details.ticketInfoes!)
                            Text("Flight Details")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 11, weight: .bold, design: .rounded))
                                .padding(5)
                                .background(.gray.opacity(0.4))
                            
                            FlightDetails(directions:(details.flightInfo?.directions)!)
                            
                            Text("Fare Details")
                                .frame(maxWidth:.infinity,alignment: .leading)
                                .font(.system(size: 11, weight: .bold, design: .rounded))
                                .padding(5)
                                .background(.gray.opacity(0.4))
                            
                            VStack(alignment: .trailing, spacing:1) {
                                FareDetailsList(passengerFares: (details.flightInfo?.passengerFares)!, passengerCounts: (details.flightInfo?.passengerCounts)!)
                                FareTotal(bookingComponent: (details.flightInfo?.bookingComponents?.first)!)
                            }
                            
                        }
                        Spacer()
                        
                    }
                    .background(.white)
                    .padding(10)
                }
            }
            else {
                ZStack {
                    SplashScreenBg
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                    VStack(spacing: 40) {
                        Spacer()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .orange))
                            .scaleEffect(2)
                        ProgressBar(isActive: $isLoading)
                            .frame(height: 3)
                            
                    }
                    .padding(.bottom, 64)
                    
                }
                
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear() {
            getAirTicketingDetails()
        }
        .alert(isPresented: $showErrorAlert) {
            Alert(title: Text(""), message: Text("No Data Found!"),
                  dismissButton: .default(Text("Close"), action: {
                self.presentationMode.wrappedValue.dismiss()
            }))
        }
    }
    
    func getAirTicketingDetails() {
        self.isLoading = true
        guard let ticketId = self.selectedBookedFlight?.uniqueTransID else {
            self.showErrorAlert.toggle()
            return
        }
        
        HttpUtility.shared.getAirTicketingDetails(ticketId: ticketId, completionHandler: { result in
            DispatchQueue.main.async { [self] in
                self.isLoading = false
                
                guard let result = result else {
                    self.showErrorAlert.toggle()
                    return
                }
                airTicketingDetails = result
            }
        })
    }
}

struct BookedFlightDetails_Previews: PreviewProvider {
    static var previews: some View {
        BookedFlightDetails()
    }
}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

struct PassengerInfo: View {
    
    var ticketInfoes: [AirTicketingDetailsResponse.TicketInfo]
    
    var body: some View {
        VStack(spacing:2){
            HStack(alignment: .center, spacing:2){
                cell(text: "Passenger Name", alignment: .center)
                cell(text: "Type", alignment: .center)
                cell(text: "Ticket Number", alignment: .center)
            }.frame(maxWidth: .infinity, alignment: .trailing)
                
            
            ForEach(self.ticketInfoes, id:\.self) { ticketInfo in
                HStack(alignment: .center, spacing:2){
                    cellItalic(text: ticketInfo.passengerInfo?.nameElement?.firstName ?? "Name", alignment: .center)
                    cellItalic(text: (ticketInfo.passengerInfo?.passengerType)!, alignment: .center)
                    cellItalic(text: (ticketInfo.ticketNumbers![0]), alignment: .center)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }

    func cell(text: String, alignment: Alignment) -> some View {
        HStack {
            VStack {
                Text(text)
                    .font(.system(size: 10, weight: .semibold, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: alignment)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: 20, maxHeight: 20)
        .background(.gray.opacity(0.4))
    }
    
    func cellItalic(text: String, alignment: Alignment) -> some View {
        HStack {
            VStack {
                Text(text)
                    .font(.system(size: 10, weight: .regular, design: .rounded).italic())
                    .frame(maxWidth: .infinity, alignment: alignment)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: 20, maxHeight: 20)
        .background(.gray.opacity(0.4))
    }
}

struct FlightDetails: View {
    var directions : [[AirTicketingDetailsResponse.FlightInfo.Direction]]
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            ForEach(self.directions, id:\.self) { direction in
                VStack(alignment: .leading, spacing: 5){
                    FlightDetailView(direction: direction.first!)
                    Line()
                       .stroke(style: StrokeStyle(lineWidth: 2, dash: [3]))
                       .frame(height: 1)
                }
            }
        }
    }
}

struct FlightDetailView:View {
    var direction: AirTicketingDetailsResponse.FlightInfo.Direction
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment:.leading){
                HStack{
                    ImageUrlView(urlString: "\(ROOT_URL_THUMB)\(direction.platingCarrierCode! ).png", sizeVal: 40)
                    .frame(width: 40, height: 40)
                    .scaledToFit()
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    Text(direction.platingCarrierName ?? "")
                        .font(.system(size: 10, weight: .medium, design: .rounded))
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                }
                
                HStack{
                    VStack{
                        Text(direction.from!)
                            .font(.system(size: 11, weight: .bold, design: .rounded))
                        VStack {
//                            Text("20:00")
//                            Text("Jul 03, 2022")
                            Text("\(getTimeString(dateStr:direction.segments?.first?.departure! ?? ""))").lineLimit(1)
                            Text("\(getDateString(dateStr:direction.segments?.first?.departure! ?? ""))").lineLimit(1)
//                            Text(direction.segments?.first?.departure! ?? "").lineLimit(1)
//                            Text(direction.segments?.first?.departure! ?? "").lineLimit(1)
                        }
                        .font(.system(size: 9, weight: .regular, design: .rounded))
                    }.frame(maxWidth: .infinity)
                    
                    HStack(spacing:0){
                        Divider()
                            .frame(width:20, height: 2)
                            .background(.gray)
                        Image(systemName: "airplane.departure")
                            .font(.system(size: 12, weight: .bold, design: .rounded))
                    }
                    
                    VStack(alignment: .leading, spacing: 2){
                        Text(direction.to!)
                            .font(.system(size: 11, weight: .bold, design: .rounded))
                        VStack {
    //                                    Text("20:00")
    //                                    Text("Jul 03, 2022")
//                            Text(direction.segments?.first?.arrival! ?? "").lineLimit(1)
//                            Text(direction.segments?.first?.arrival! ?? "").lineLimit(1)
                            Text("\(getTimeString(dateStr:direction.segments?.first?.arrival! ?? ""))").lineLimit(1)
                            Text("\(getDateString(dateStr:direction.segments?.first?.arrival! ?? ""))").lineLimit(1)
                        }
                        .font(.system(size: 9, weight: .regular, design: .rounded))
                        
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .frame(minWidth:0, maxWidth: .infinity)
            .font(.system(size: 10, weight: .regular, design: .rounded))
            
            Divider().frame(maxWidth: 1.5, minHeight: 90, maxHeight: 90)
            .background(.gray.opacity(0.3))
            
            VStack(alignment: .leading, spacing: 5){
                HStack(alignment: .top){
    //                            Text("BS 115")
    //                                .frame(width: 80)
    //                            Text("O")
                    Text("\((direction.segments?.first?.airlineCode!)!)  \((direction.segments?.first?.flightNumber!)!)")
                        .frame(width: 80)
                    Text("\(direction.stops)")
                    
                }
                HStack{
                    Text("DEPART")
                        .frame(width: 80)
                    Text(direction.fromAirport ?? "").lineLimit(2)
                }
                HStack{
                    Text("ARRIVES")
                        .frame(width: 80)
                    Text(direction.toAirport ?? "").lineLimit(2)
                }
                HStack{
                    Text("BAGGAGE")
                        .frame(width: 80)
                    Text("\((direction.segments?.first?.baggage?.first?.amount)!)  \((direction.segments?.first?.baggage?.first?.units!)!)")
                }
                HStack{
                    Text("AIRLINE PNR")
                        .frame(width: 80)
                    Text("044A34L")
                }
            }
            .font(.system(size: 9, weight: .regular, design: .rounded))
            .frame(minWidth:0, maxWidth: .infinity)
            
        }
        .frame(maxWidth: .infinity, minHeight: 90, maxHeight: 90)
    }
    
}

struct FareDetails: View {
    var type: String
    var count: Int
    var passengerFare: AirTicketingDetailsResponse.FlightInfo.PassengerFares.PassengerFare
    
    var body: some View {
        HStack(alignment: .center, spacing:1) {
            HStack(alignment: .center, spacing:1){
                cell(text: "\(type)", alignment: .center)
                cell(text: "\(passengerFare.basePrice)", alignment: .center)
                cell(text: "\(passengerFare.taxes)", alignment: .center)
                    .frame(width: 40)
            }.frame(maxWidth: .infinity, alignment: .trailing)
            HStack(spacing:1){
                cell(text: "0", alignment: .trailing)
                cell(text: "\(count)", alignment: .trailing)
                cell(text: "\(passengerFare.totalPrice)", alignment: .trailing)
                    .frame(width: 70)
            }.frame(maxWidth: .infinity, alignment: .trailing)
        }
    }

    func cell(text: String, alignment: Alignment) -> some View {
        HStack {
            VStack {
                Text(text)
                    .font(.system(size: 9, weight: .regular, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: alignment)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: 20, maxHeight: 20)
        .background(.gray.opacity(0.4))
    }
}

struct FareDetailsList: View {
    var passengerFares: AirTicketingDetailsResponse.FlightInfo.PassengerFares
    var passengerCounts: AirTicketingDetailsResponse.FlightInfo.PassengerCounts
    
    var body: some View {
        VStack(spacing:1) {
            
            HStack(alignment: .center, spacing: 1) {
                HStack(alignment: .center, spacing:1) {
                    cell(text: "Pax Type", alignment: .center)
                    cell(text: "Base Fare", alignment: .center)
                    cell(text: "Tax", alignment: .center)
                        .frame(width: 40)
                }.frame(maxWidth: .infinity, alignment: .trailing)
                HStack(spacing: 1){
                    cell(text: "Fees", alignment: .trailing)
                    cell(text: "Person", alignment: .trailing)
                    cell(text: "Total", alignment: .trailing)
                        .frame(width: 70)
                }.frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            if passengerFares.adt != nil {
                FareDetails(type:"Adult", count: passengerCounts.adt, passengerFare: passengerFares.adt!)
            }
            if passengerFares.cnn != nil {
                FareDetails(type:"Child", count: passengerCounts.cnn, passengerFare: passengerFares.cnn!)
            }
            if passengerFares.inf != nil {
                FareDetails(type:"Infant", count: passengerCounts.inf, passengerFare: passengerFares.inf!)
            }
            if passengerFares.ins != nil {
                FareDetails(type:"Ins", count: passengerCounts.ins, passengerFare: passengerFares.ins!)
            }
            
//            HStack(alignment: .center, spacing:2) {
//                HStack(alignment: .center, spacing:2){
//                    cell(text: "336.851", alignment: .center)
//                    cell(text: "336.851", alignment: .center)
//                    cell(text: "336.851", alignment: .center)
//                }.frame(maxWidth: .infinity, alignment: .trailing)
//                HStack(spacing:2){
//                    cell(text: "33", alignment: .trailing)
//                    cell(text: "33", alignment: .trailing)
//                    cell(text: "336.851", alignment: .trailing)
//                        .frame(width: 90)
//                }.frame(maxWidth: .infinity, alignment: .trailing)
//            }
        }
    }

    func cell(text: String, alignment: Alignment) -> some View {
        HStack {
            VStack {
                Text(text)
                    .font(.system(size: 9, weight: .regular, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: alignment)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: 20, maxHeight: 20)
        .background(.gray.opacity(0.4))
    }
}

struct FareTotal: View {
    var bookingComponent: AirTicketingDetailsResponse.FlightInfo.BookingComponent
    
    var body: some View {
        VStack(alignment: .trailing, spacing:1) {
            HStack(spacing:1) {
                Spacer().frame(maxWidth: .infinity)
                HStack(spacing:1) {
                    cell(text: "Total", alignment: .trailing)
                    cell(text: "\(bookingComponent.totalPrice)", alignment: .trailing)
                        .frame(width: 70)
                }.frame(maxWidth: .infinity)
            }
            
            HStack(spacing:1) {
                Spacer().frame(maxWidth: .infinity)
                HStack(spacing:1) {
                    cell(text: "(-)Discount", alignment: .trailing)
                    cell(text: "\(bookingComponent.discountPrice)", alignment: .trailing)
                        .frame(width: 70)
                }.frame(maxWidth: .infinity)
            }
            
            HStack(spacing:1) {
                Spacer().frame(maxWidth: .infinity)
                HStack(spacing:1) {
                    cell(text: "(+)AIT", alignment: .trailing)
                    cell(text: "\(bookingComponent.ait)", alignment: .trailing)
                        .frame(width: 70)
                }.frame(maxWidth: .infinity)
            }
            
            HStack(spacing:1) {
                Spacer().frame(maxWidth: .infinity)
                HStack(spacing:1) {
                    cell(text: "Grand Total", alignment: .trailing)
                    cell(text: "\(bookingComponent.basePrice)", alignment: .trailing)
                        .frame(width: 70)
                }.frame(maxWidth: .infinity)
            }
        }
    }

    func cell(text: String, alignment: Alignment) -> some View {
        HStack {
            VStack {
                Text(text)
                    .font(.system(size: 10, weight: .regular, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: alignment)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: 20, maxHeight: 20)
        .background(.gray.opacity(0.4))
    }
}
