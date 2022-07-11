//
//  ImageUrlView.swift
//  flightexpert
//
//  Created by sohan on 7/9/22.
//

import SwiftUI

struct ImageUrlView: View {
    @ObservedObject var imageUrlModel: ImageUrlModel
        
    init(urlString: String?) {
        imageUrlModel = ImageUrlModel(urlString: urlString)
    }
    
    var body: some View {
        Image(uiImage: (imageUrlModel.image ?? ImageUrlView.defaultImage)!)
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40)
    }
    
    static var defaultImage = UIImage(named: "biman-bd-icon")
}

struct ImageUrlView_Previews: PreviewProvider {
    static var previews: some View {
        ImageUrlView(urlString: nil)
    }
}
