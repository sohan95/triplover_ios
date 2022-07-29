//
//  SSLViewRepresentable.swift
//  flightexpert
//
//  Created by sohan on 7/29/22.
//

import SwiftUI
import Combine
import SSLCommerzSDK

//struct SSLViewRepresentable: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}

struct VCRepresented : UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SSLCmzViewController {
        return SSLCmzViewController()
    }

    func updateUIViewController(_ uiViewController: SSLCmzViewController, context: Context) {

    }
}

//struct SSLViewRepresentable_Previews: PreviewProvider {
//    static var previews: some View {
//        VCRepresented()
//    }
//}
//enum LinkAction {
//    case takePhoto
//}
//
//class VCLink : ObservableObject {
//    @Published var action : LinkAction?
//    @Published var name : String = ""
//    @Published var amount : String?
//
//    func takePhoto() {
//        action = .takePhoto
//    }
//}


