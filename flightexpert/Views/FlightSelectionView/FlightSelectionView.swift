//
//  FlightSelectionView.swift
//  flightexpert
//
//  Created by sohan on 6/1/22.
//

import SwiftUI

var sortCategoryList = ["Price Low","Price High","Time ASC","Time DESC"]
//var airlineList:[String] = ["Biman Bangladesh", "Novo Air", "US Bangla",]
var stopsList:[String] = ["Non-Stop", "1 Stop", "2 or More Stops"]

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

struct FlightSelectionView: View {
    //@ObservedObject var flightSearchModel: FlightSearchModel
    @EnvironmentObject var flightSearchModel: FlightSearchModel
    @State private var sheetMode: SheetMode = .none
    
//    @State private var isSelectBtnTapped: Bool = false
    @State private var selection: String? = nil
    @State private var popUpTitle: String = "Close"
    @State var currentDirectionList: [Direction] = []
    @State var currentDirection: Direction? = nil
    
    //For Filter
    @State var show = false
    @State var selectedSortCategory = "Price Low"

    @State var isFilterShown = false
    @State var selectedStop: String = ""
    @State var selectedAirline: String = ""
    
    @State var filterTypeIndex: Int = 2
    @State var selectedFilterItem: [String] = []
    @State var selectedMinPrice: Double = 0.0
    @State var selectedMaxPrice: Double = 0.0
    //@State var selectedMinMaxPrice: MinMaxPrice = MinMaxPrice(minPrice: 0.0, maxPrice: 0.0)
    @State var bottomPadding: CGFloat = 50.0
    @Environment(\.presentationMode) var presentationMode
    var btnBack : some View { Button(action: {
            if isFilterShown == false  && show == false {
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
            
            NavigationLink(destination:SelectedFlightDetails(), tag: "SelectedFlightDetails", selection: $selection) { EmptyView() }
        
            VStack(spacing: 5) {
                HStack{
                    Spacer()
                    Text("\(currentDirectionList.count) Flight/s found")
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundColor(.black)
                        .padding(7)
                        .background(.white)
                        .cornerRadius(4)
                }
                .padding(.trailing, 5)
                
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(currentDirectionList, id: \.self) { direction in
                            FlightCell(direction: direction, currency: flightSearchModel.currency!,
                                    isSelectBtnTapped: $flightSearchModel.isSelectBtnTapped, selectedDirection:currentDirection) { directionResult in
                                
                                if flightSearchModel.isSelectBtnTapped {
                                    selectFlightDirection(direction: directionResult)
                                } else {
                                    self.gotoDetailsView(direction: directionResult)
                                }
                            }
                        }
                    }
                }
                .frame(minWidth:0, maxWidth: .infinity, minHeight:0, maxHeight: .infinity)
                .navigationBarTitleDisplayMode(.inline)

                .toolbar(){
                    ToolbarItem(placement: .principal) {
                        VStack (alignment: .center) {
                            HStack(spacing: 5){
                                if let routes = flightSearchModel.searchFlighRequest!.routes {
                                    ForEach(0 ..< routes.count, id:\.self) { i in
                                        HStack(spacing:3){
                                            Text("\(routes[i].origin)")
                                            Image(systemName: "airplane.departure")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 10, height: 10, alignment: .center)
                                            Text("\(routes[i].destination)")
                                        }
                                        .font(.system(size: 10, weight: .semibold, design: .rounded))
                                        .foregroundColor(.white)
                                        .padding(7)
                                        .background(self.flightSearchModel.routeIndex == i ? Color("button-bg-color") : Color.gray.opacity(0.4))
                                        .cornerRadius(4)
                                    }
                                }
                            }
                        }
                        
                    }
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: btnBack)
                
                //Bottom: Button Option View
                VStack{
                    VStack {
                        Button {
                            //Flight Details
                            guard self.currentDirection != nil else {
                                return
                            }

                            self.gotoDetailsView(direction: self.currentDirection!)
                        } label: {
                            HStack{
                                Spacer()
                                Text("FLIGHT DETAILS")
                                Spacer()
                                Image(systemName: "arrowtriangle.down.fill")
                                    .frame(width: 10, height: 5)
                            }
                            .frame(minWidth:0, maxWidth: .infinity)
                            .font(.system(size: 12, weight: .bold, design: .rounded))
                            .padding(12)
                            .background(blueGradient)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            
                        }
                        
                        HStack{
                            Button {
                                //sheetMode = .semi
                                withAnimation {
                                    self.isFilterShown.toggle()
                                }
                            } label: {
                                Label("Filter", systemImage: "line.3.horizontal.decrease")
                                    .frame(minWidth:0, maxWidth: .infinity)
                                    .font(.system(size: 11, weight: .semibold, design: .rounded))
                                    .padding(10)
                                    .background(blueGradient)
                                    .foregroundColor(.white)
                                    .cornerRadius(15)
                            }
                            
                            
                            Button {
                                withAnimation {
                                    show.toggle()
                                }
                            } label: {
                                Label("Sort By", systemImage: "line.3.horizontal.decrease")
                                    .frame(minWidth:0, maxWidth: .infinity)
                                    .font(.system(size: 11, weight: .semibold, design: .rounded))
                                    .padding(10)
                                    .background(blueGradient)
                                    .foregroundColor(.white)
                                    .cornerRadius(15)
                            }
                            
                        }
                    }
                    .padding(.horizontal,10)
                    Spacer()
                }
                .frame(minWidth:0, maxWidth: .infinity, minHeight:0, maxHeight: bottomPadding+90)
                
            }
            .padding(.top, bottomPadding)
            .onAppear(perform: {
                updateOnAppear()
            })
            .onTapGesture {
                withAnimation {
                    self.isFilterShown = false;
                }
            }
            
            // Sort By option popup
            VStack{
                Spacer()
                RadioButtonsPopup(selected: $selectedSortCategory, show: self.$show) {
                    doSelectedSorting()
                }
                .offset(y: self.show ? (UIApplication.shared.currentUIWindow()?.safeAreaInsets.bottom)! + 15 : UIScreen.main.bounds.height)
                
            }
            .background(Color(UIColor.label.withAlphaComponent(self.show ? 0.3 : 0)).edgesIgnoringSafeArea(.all))
            
            .transition(.asymmetric(insertion: .scale, removal: .opacity))
            
               
            // Filter Option View
            if (isFilterShown) {
                FilterBottomPopup(filterTypeIndex:$filterTypeIndex, selectedStop: $selectedStop, selectedAirline: $selectedAirline, selectedMinPrice: $selectedMinPrice, selectedMaxPrice: $selectedMaxPrice, slider: CustomSlider(start: flightSearchModel.minMaxPrice.minPrice, end: flightSearchModel.minMaxPrice.maxPrice, currentMin: selectedMinPrice, currentMax: selectedMaxPrice)) { isApply in
                    withAnimation {
                        self.isFilterShown.toggle()
                    }
                    print("selectedMinPrice =\(selectedMinPrice)")
                    print("selectedMaxPrice =\(selectedMaxPrice)")
                    
                    self.resetDataForView()
                    if isApply {
                        doFilterAction()
                    }
                }
            }
        }
        .environmentObject(flightSearchModel)
    }
    
    func updateOnAppear() {

        //check Device Notch
        if UIDevice.current.hasNotch {
            //... consider notch
            bottomPadding = 50.0
        } else {
            bottomPadding = 100.0
        }
        
        if isFilterShown {
            return
        }
        
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
        
        
        self.selectedMinPrice = flightSearchModel.minMaxPrice.minPrice
        self.selectedMaxPrice = flightSearchModel.minMaxPrice.maxPrice
        print("selectedMinPrice =\(selectedMinPrice)")
        print("selectedMaxPrice =\(selectedMaxPrice)")
    }
    
    func resetDataForView() {

        if isFilterShown {
            return
        }
        
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
    
    func gotoDetailsView(direction: Direction) {
        if isFilterShown {
            return
        }
        
        flightSearchModel.detailsDir = direction
        selection = "SelectedFlightDetails"
        
    }
    
    
    func selectFlightDirection(direction: Direction) {
        if isFilterShown {
            return
        }
        // Set selected direction flight & update local selection
        flightSearchModel.setSelectedFlightList(direction: direction)
        
        //Next steps
        if flightSearchModel.isOneWay {
            selection = "SelectedFlightDetails"
        } else if flightSearchModel.isRoundTrip {
            if flightSearchModel.routeIndex == 0 {
                flightSearchModel.routeIndex = 1
                flightSearchModel.getFollowingDirection()
                self.currentDirectionList = flightSearchModel.selectedDirectionList[1]
                self.currentDirection = flightSearchModel.getSelectedFlight(index: 1)
            } else if flightSearchModel.routeIndex == 1 {
                selection = "SelectedFlightDetails"
            }
        } else if flightSearchModel.isMultiCity {
            if flightSearchModel.routeIndex == (flightSearchModel.searchFlighRequest?.routes.count)!-1 {
                selection = "SelectedFlightDetails"
            } else if flightSearchModel.routeIndex < (flightSearchModel.searchFlighRequest?.routes.count)!-1 {
                flightSearchModel.routeIndex += 1
                flightSearchModel.getFollowingDirection()
                self.currentDirectionList = flightSearchModel.selectedDirectionList[flightSearchModel.routeIndex]
                self.currentDirection = flightSearchModel.getSelectedFlight(index: flightSearchModel.routeIndex)
            }
        }
        
    }
    
    func doSelectedSorting() {
        //["Price Low","Price High","Time ASC","Time DESC"]
        if self.selectedSortCategory == "Price Low" {
            currentDirectionList = currentDirectionList.sorted(by: { $0.totalPrice! < $1.totalPrice! })
        }
        else if self.selectedSortCategory == "Price High" {
            currentDirectionList = currentDirectionList.sorted(by: { $0.totalPrice! > $1.totalPrice! })
        } else if self.selectedSortCategory == "Time ASC" {
            //getDateFromStringAndFormate
            currentDirectionList = currentDirectionList.sorted(by: { getDateFromString(dateStr:$0.departure!).compare(getDateFromString(dateStr:$1.departure!)) == .orderedAscending })
        } else if self.selectedSortCategory == "Time DESC" {
            currentDirectionList = currentDirectionList.sorted(by: { getDateFromString(dateStr:$0.departure!).compare(getDateFromString(dateStr:$1.departure!)) == .orderedDescending })
        }
        withAnimation {
            self.show.toggle()
        }
    }
    
    func getStopFilter() -> Int {
        if self.selectedStop == stopsList[0] {
            return 0
        } else if self.selectedStop == stopsList[1] {
            return 1
        } else if self.selectedStop == stopsList[2] {
            return 2
        } else {
            return -1
        }
    }
    
    func doFilterAction() {
        print("Do filter Action")
        
        // Filter-by-Airline
        var filteredArray: [Direction] = []
        if selectedAirline.count > 0 {
            filteredArray = currentDirectionList.filter { $0.platingCarrierName!.localizedCaseInsensitiveContains(selectedAirline) }
        }
        
    
        // Filter-by-Stops
        if selectedStop.count > 0 {
            let stopFilter: Int = getStopFilter()
            if stopFilter < 2 {
                filteredArray = filteredArray.filter { $0.stops == stopFilter }
            } else {
                filteredArray = filteredArray.filter { $0.stops >= stopFilter }
            }
        }
        
        // Filter-by-TotalPrice-Range
        if (filteredArray.isEmpty) {
            filteredArray = currentDirectionList;
        }
        print("basePrice=\(selectedMinPrice)");
        print("basePrice=\(selectedMaxPrice)");
        
        filteredArray = filteredArray.filter({ ($0.bookingComponents?[0].basePrice)! >= selectedMinPrice && ($0.bookingComponents?[0].basePrice)! <= selectedMaxPrice })
        currentDirectionList = filteredArray
    }
    
}

struct FlightSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        FlightSelectionView()
    }
}

public extension UIApplication {
    func currentUIWindow() -> UIWindow? {
        let connectedScenes = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
        
        let window = connectedScenes.first?
            .windows
            .first { $0.isKeyWindow }

        return window
        
    }
}


