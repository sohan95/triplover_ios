//
//  FlightDetailsView.swift
//  flightexpert
//
//  Created by sohan on 6/6/22.
//

import SwiftUI

//enum SheetMode {
//    case none
//    case quater
//    case half
//    case full
//}

struct FlightDetailsView<Content: View>: View {
    
    let content: () -> Content
    var sheetMode:Binding<SheetMode>
    
//    @Environment(\.presentationMode) var presentationMode
//
//    var selectedModel: RandomModel
//    var selectedDirection: Direction
//
//    typealias Action = (Direction) -> Void
//    var action: Action?
    
    private func calculateOffset() -> CGFloat {
        switch sheetMode.wrappedValue {
            case .none:
                return UIScreen.main.bounds.height
            case .quater:
                return UIScreen.main.bounds.height - 200
            case .semi:
                return UIScreen.main.bounds.height/3
            case .half:
                return UIScreen.main.bounds.height/2
            case .full:
                return 0
        }
    }
    
    init(sheetMode:Binding<SheetMode>, @ViewBuilder content:@escaping ()-> Content) {
        self.content = content
        self.sheetMode = sheetMode
    }
    
    var body: some View {
        content()
            .offset(y: calculateOffset())
            .animation(.spring())
            .ignoresSafeArea(.all)
        
//        Text(selectedModel.title)
//        Text(selectedModel.iata)
//        Text("Hello")
//        Text("Hello")
//        Button("Close") {
//            presentationMode.wrappedValue.dismiss()
//        }
//        Button("Confirm") {
//
//            if let action = action {
//                action(selectedDirection)
//            }
//            presentationMode.wrappedValue.dismiss()
//        }
    }
}


struct FlightDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        FlightDetailsView(sheetMode: .constant(.none)) {
            VStack{
                Text("None")
            }.frame(width: .infinity, height: .infinity)
            .background(.blue)
        }
    }
}
