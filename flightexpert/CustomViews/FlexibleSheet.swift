//
//  FlexibleSheetView.swift
//  flightexpert
//
//  Created by sohan on 6/6/22.
//

import SwiftUI

enum SheetMode {
    case none
    case quater
    case semi
    case half
    case full
}

struct FlexibleSheet<Content: View>: View {
    
    let content: () -> Content
    var sheetMode:Binding<SheetMode>
    
    private func calculateOffset() -> CGFloat {
        switch sheetMode.wrappedValue {
            case .none:
                return UIScreen.main.bounds.height
            case .quater:
                return UIScreen.main.bounds.height - 200
            case .semi:
                return UIScreen.main.bounds.height - 280
            case .half:
                return UIScreen.main.bounds.height/2
            case .full:
                return 0
        }
    }
    
    init(sheetMode:Binding<SheetMode>, @ViewBuilder content:@escaping ()-> Content) {
        self.content = content
        self.sheetMode = sheetMode
        print("\(UIScreen.main.bounds.height): offset=\(calculateOffset())")
        
    }
    
    var body: some View {
        content()
            .offset(y: calculateOffset())
            .animation(.spring())
            .ignoresSafeArea(.all)
    }
     
}

struct FlexibleSheetView_Previews: PreviewProvider {
    static var previews: some View {
        FlexibleSheet(sheetMode: .constant(.quater)) {
            VStack{
                Text("None")
            }.frame(width: .infinity, height: .infinity)
            .background(.blue)
        }
    }
}

