//
//  OriginFlightList.swift
//  flightexpert
//
//  Created by sohan on 6/1/22.
//

import SwiftUI

struct Stack {
    private var myArray: [Direction] = []
    
    mutating func push(_ element: Direction) {
        myArray.append(element)
    }
    
    mutating func pop() -> Direction? {
        return myArray.popLast()
    }
    
    func peek() -> Direction? {
        guard let topElement = myArray.last else {
            return nil
        }
        return topElement
    }
}

struct OriginFlightList: View {
    var title:String
    //@ObservedObject var flightSearchModel: FlightSearchModel
    @EnvironmentObject var flightSearchModel: FlightSearchModel
//    @State private var sheetMode: SheetMode = .none
//    @State private var isSelectBtnTapped: Bool = false
    @State private var selection: String? = nil
    @State private var popUpTitle: String = "Close"
    @State var currentDirectionList: [Direction] = []
    @State var currentDirection: Direction? = nil
    
    @Environment(\.presentationMode) var presentationMode
    var btnBack : some View { Button(action: {
            if flightSearchModel.isOneWay {
                self.presentationMode.wrappedValue.dismiss()
            } else if flightSearchModel.isRoundTrip {
                if flightSearchModel.routeIndex == 0 {
                    self.presentationMode.wrappedValue.dismiss()
                } else if flightSearchModel.routeIndex == 1 {
                    flightSearchModel.routeIndex = 0
                    self.currentDirectionList = flightSearchModel.selectedDirectionList[flightSearchModel.routeIndex]
                    self.currentDirection = flightSearchModel.getSelectedFlight(index: flightSearchModel.routeIndex)
                }
                
            } else if flightSearchModel.isMultiCity {
                if flightSearchModel.routeIndex == 0 {
                    self.presentationMode.wrappedValue.dismiss()
                } else if flightSearchModel.routeIndex > 0 {
                    flightSearchModel.routeIndex -= 1
                    self.currentDirectionList = flightSearchModel.selectedDirectionList[flightSearchModel.routeIndex]
                    self.currentDirection = flightSearchModel.getSelectedFlight(index: flightSearchModel.routeIndex)
                }
            }
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
            BackgroundImage
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            NavigationLink(destination:RoutesConfirmView(), tag: "RoutesConfirmView", selection: $selection) { EmptyView() }
            
//            if !flightSearchModel.isSearching {
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(currentDirectionList, id: \.self) { direction in
                            ListRow(direction: direction,
                                    isSelectBtnTapped: $flightSearchModel.isSelectBtnTapped, selectedDirection:currentDirection) { directionResult in
                                
                                if flightSearchModel.isSelectBtnTapped {
                                    selectFlightDirection(direction: directionResult)
                                } else {
                                    flightSearchModel.detailsDir = directionResult
                                    selection = "RoutesConfirmView"
                                }
                            }
                        }
                        
                    }
                    .offset(y: 64)
//                    .clipped()
                }
                .frame(minHeight: 480, maxHeight:.infinity)
                .navigationTitle("Flight")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .toolbar(){
                    ToolbarItem(placement: .principal) {
                        VStack {
                            HStack(spacing: 5){
                                if let routes = flightSearchModel.searchFlighRequest!.routes {
                                    ForEach(0 ..< routes.count, id:\.self) { i in
                                        HStack(spacing:3){
                                            Text("\(routes[i].origin)")
                                            Image(systemName: "airplane.departure")
                                            Text("\(routes[i].destination)")
                                        }
                                        .font(.system(size: 11, weight: .heavy, design: .rounded))
                                        .foregroundColor(.white)
                                        .padding(5)
                                        .background(self.flightSearchModel.routeIndex == i ? .black : Color.gray.opacity(0.5))
                                        .cornerRadius(5)
                                        
                                            
                                    }
                                }
                            }
                            HStack{
                                Spacer()
                                Text("\(currentDirectionList.count) Flight/s found")
                                    .font(.system(size: 10, weight: .semibold, design: .rounded))
                                    .foregroundColor(.black)
                                    .padding(.horizontal,10)
                                    .padding(.vertical,5)
                                    .background(.white)
                                    .cornerRadius(5)
                            }
                        }
                        
                    }
                }
                .navigationBarItems(leading: btnBack)
                .onAppear() {
                    updateOnAppear()
                }
//                .onTapGesture {
//                    //sheetMode = .none
//                }
                /*
                FlexibleSheet(sheetMode: $sheetMode) {
                    ZStack {
                        backgroundGradient
                            .ignoresSafeArea()
                        
                        if let selected = self.flightSearchModel.originDir {
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
                                        Text(self.popUpTitle)
                                            .frame(width:50)
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
                 */
//            }
//            else {
//                LoadingView()
//            }
        }
        .environmentObject(flightSearchModel)
    }
    
    func updateOnAppear() {
        if flightSearchModel.isOneWay {
            flightSearchModel.routeIndex = 0
            flightSearchModel.getForwardDirection()
            self.currentDirectionList = flightSearchModel.selectedDirectionList[0]
            self.currentDirection = flightSearchModel.getSelectedFlight(index: 0)
            
        } else if flightSearchModel.isRoundTrip {
            if flightSearchModel.routeIndex == 0 {
                flightSearchModel.getForwardDirection()
                self.currentDirectionList = flightSearchModel.selectedDirectionList[0]
                self.currentDirection = flightSearchModel.getSelectedFlight(index: 0)
                
            } else if flightSearchModel.routeIndex == 1 {
                flightSearchModel.getFollowingDirection()
                self.currentDirectionList = flightSearchModel.selectedDirectionList[1]
                self.currentDirection = flightSearchModel.getSelectedFlight(index: 1)
            }
        } else if flightSearchModel.isMultiCity {
            
            if flightSearchModel.routeIndex == 0 {
                flightSearchModel.getForwardDirection()
                self.currentDirectionList = flightSearchModel.selectedDirectionList[0]
                self.currentDirection = flightSearchModel.getSelectedFlight(index: 0)
                
            } else if flightSearchModel.routeIndex == 1 {
                flightSearchModel.getFollowingDirection()
                self.currentDirectionList = flightSearchModel.selectedDirectionList[1]
                self.currentDirection = flightSearchModel.getSelectedFlight(index: 1)
                
            } else if flightSearchModel.routeIndex == 2 {
                flightSearchModel.getFollowingDirection()
                self.currentDirectionList = flightSearchModel.selectedDirectionList[2]
                self.currentDirection = flightSearchModel.getSelectedFlight(index: 2)
                
            } else if flightSearchModel.routeIndex == 3 {
                flightSearchModel.getFollowingDirection()
                self.currentDirectionList = flightSearchModel.selectedDirectionList[3]
                self.currentDirection = flightSearchModel.getSelectedFlight(index: 3)
            }
        }
    }
    
//    func selectOriginFlight(direction: Direction) {
//        flightSearchModel.setOrigin(direction: direction)
//    }
    
    func selectFlightDirection(direction: Direction) {
        // Set selected direction flight & update local selection
        flightSearchModel.setSelectedFlightList(direction: direction)
        
        //Next steps
        if flightSearchModel.isOneWay {
            selection = "RoutesConfirmView"
        } else if flightSearchModel.isRoundTrip {
            if flightSearchModel.routeIndex == 0 {
                flightSearchModel.routeIndex = 1
                flightSearchModel.getFollowingDirection()
                self.currentDirectionList = flightSearchModel.selectedDirectionList[1]
                self.currentDirection = flightSearchModel.getSelectedFlight(index: 1)
            } else if flightSearchModel.routeIndex == 1 {
                selection = "RoutesConfirmView"
            }
        } else if flightSearchModel.isMultiCity {
            if flightSearchModel.routeIndex == (flightSearchModel.searchFlighRequest?.routes.count)!-1 {
                selection = "RoutesConfirmView"
            } else if flightSearchModel.routeIndex < (flightSearchModel.searchFlighRequest?.routes.count)!-1 {
                flightSearchModel.routeIndex += 1
                flightSearchModel.getFollowingDirection()
                self.currentDirectionList = flightSearchModel.selectedDirectionList[flightSearchModel.routeIndex]
                self.currentDirection = flightSearchModel.getSelectedFlight(index: flightSearchModel.routeIndex)
            }
        }
        
    }
    
}

struct OriginFlightList_Previews: PreviewProvider {
    static var previews: some View {
       // OriginFlightList(
        OriginFlightList(title: "Source")
    }
}


