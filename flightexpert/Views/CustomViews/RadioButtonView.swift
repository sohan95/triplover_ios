//
//  RadioButtonView.swift
//  flightexpert
//
//  Created by sohan on 7/27/22.
//

import SwiftUI

struct RadioButtonView: View {
    let id: String
    let label: String
    let size: CGFloat
    let color: Color
    let textSize: CGFloat
    let isMarked:Bool
    let callback: (String)->()
    
    init(
        id: String,
        label:String,
        size: CGFloat = 12,
        color: Color = Color.white,
        textSize: CGFloat = 10,
        isMarked: Bool = false,
        callback: @escaping (String)->()
        ) {
        self.id = id
        self.label = label
        self.size = size
        self.color = color
        self.textSize = textSize
        self.isMarked = isMarked
        self.callback = callback
    }
    
    var body: some View {
        Button(action:{
            self.callback(self.id)
        }) {
            HStack(alignment: .center, spacing: 5) {
                Image(systemName: "circle.inset.filled")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                    .foregroundColor(self.isMarked ? Color("title_third") : self.color)
                Text(label)
                    .font(Font.system(size: textSize, weight: .bold, design: .rounded))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                    .foregroundColor(self.color)
            }
            .frame(minWidth:0, maxWidth:.infinity)
            .padding(.vertical, 7)
            
        }
        .background(
            RoundedRectangle(cornerRadius: 5).fill(Color("colorPrimary"))
        )
    }
}

struct RadioButtonView_Previews: PreviewProvider {
    static var previews: some View {
        RadioButtonView(id: "ABCD", label: "ABCD") { nAME in
            //
        }
    }
}
