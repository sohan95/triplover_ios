//
//  ImageUrlView.swift
//  flightexpert
//
//  Created by sohan on 7/9/22.
//

import SwiftUI

struct ImageUrlView: View {
    @ObservedObject var imageUrlModel: ImageUrlModel
    var sizeVal: CGFloat = 40
    
    init(urlString: String?, sizeVal: CGFloat) {
        imageUrlModel = ImageUrlModel(urlString: urlString)
        self.sizeVal = sizeVal
    }
    
    var body: some View {
        
        Image(uiImage: (imageUrlModel.image ?? ImageUrlView.defaultImage)!)
            .resizable()
            .scaledToFit()
            .frame(width: sizeVal, height: sizeVal)
            
    }
    
    static var defaultImage = UIImage(named: "biman-bd-icon")
}

struct ImageUrlView_Previews: PreviewProvider {
    static var previews: some View {
        ImageUrlView(urlString: nil,sizeVal: 60)
    }
}
