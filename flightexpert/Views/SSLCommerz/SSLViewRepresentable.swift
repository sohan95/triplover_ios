//
//  SSLViewRepresentable.swift
//  flightexpert
//
//  Created by sohan on 7/29/22.
//



import Foundation
import UIKit
import SwiftUI
import Combine
import SSLCommerzSDK


struct VCRepresented : UIViewControllerRepresentable {
    @Binding var data: Int
    @Binding var isShownSSL: Bool
//    @Binding var doneAction : () -> ()
//    func makeUIViewController(context: Context) -> some UIViewController {
//        return UIViewController()
//    }
    
    
    func makeUIViewController(context: Context) -> SSLCmzViewController {
        return SSLCmzViewController(data: $data, isShownSSL: $isShownSSL)
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        //
    }

//    func updateUIViewController(_ uiViewController: SSLCmzViewController, context: Context) {
//
//    }
    
}

class SSLCmzViewController: UIViewController, SSLCommerzDelegate {
    @Published var delegate:SSLCommerzDelegate?
    @Published var sslCom: SSLCommerz?
    static var balerPrice: Double = 0.0;
    static var balerId: String = "";

    @Binding private var data: Int
    @Binding var isShownSSL: Bool
//    var doneAction : () -> ()
    static var callback : ((BookingConfirmResponse?) -> Void)?



    init(data: Binding<Int>, isShownSSL: Binding<Bool>) {
            self._data = data
            self._isShownSSL = isShownSSL
            super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.initSSLCmz()
        }
    }

    func initSSLCmz(){

        print("balerPrice= .\(SSLCmzViewController.balerPrice)")
        print("balerId= .\(SSLCmzViewController.balerId)")
        
        data = 4
        sslCom = SSLCommerz.init(integrationInformation: .init(storeID: "tripl627f321a2eb5a", storePassword: "tripl627f321a2eb5a@ssl", totalAmount: SSLCmzViewController.balerPrice, currency: "BDT", transactionId: SSLCmzViewController.balerId, productCategory: "TripLover"), emiInformation: nil, customerInformation:nil, shipmentInformation: nil, productInformation: nil, additionalInformation: nil)
        
//        sslCom = SSLCommerz.init(integrationInformation: .init(storeID: "tripl627f321a2eb5a", storePassword: "tripl627f321a2eb5a@ssl", totalAmount: 1000.00, currency: "BDT", transactionId: "TLL1626185596", productCategory: "TripLover"), emiInformation: nil, customerInformation:nil, shipmentInformation: nil, productInformation: nil, additionalInformation: nil)
        
        sslCom?.delegate = self
        sslCom?.start(in: self, shouldRunInTestMode: true)
    }

    func transactionCompleted(withTransactionData transactionData: TransactionDetails?) {
        //print(JSONSerializer.toJson(transactionData!))
        let ssl_response: Ssl_response = Ssl_response(aPIConnect: transactionData?.apiConnect, amount: transactionData?.amount, bank_tran_id: transactionData?.bank_tran_id, base_fair: transactionData?.base_fair, card_brand: transactionData?.card_brand, card_issuer: transactionData?.card_issuer, card_issuer_country: transactionData?.card_issuer_country, card_issuer_country_code: transactionData?.card_issuer_country_code, card_no: transactionData?.card_no, card_type: transactionData?.card_type, currency_amount: transactionData?.currency_amount, currency_rate: transactionData?.currency_rate, currency_type: transactionData?.currency_type, gw_version: transactionData?.gw_version, risk_level: transactionData?.risk_level, risk_title: transactionData?.risk_title, sessionsessionkey: transactionData?.sessionkey, status: transactionData?.status, store_amount: transactionData?.store_amount, tran_date: transactionData?.tran_date, tran_id: transactionData?.tran_id, val_id: transactionData?.val_id, validated_on: transactionData?.validated_on, value_a: transactionData?.value_a, value_b: transactionData?.value_b, value_c: transactionData?.value_c, value_d: transactionData?.value_d)

        let sslcmzRequest: SSLComerzResponse = SSLComerzResponse(uniqueTransID: transactionData?.tran_id, ssl_response: ssl_response)
        print("sslcmzRequest=\(sslcmzRequest)")

        HttpUtility.shared.bookingConfirm(requestBody: sslcmzRequest) { result in

            DispatchQueue.main.async { [self] in
                //self.isBooking = false

                guard let result = result else {
                    return
                    //fatalError("There must be a problem decoding the data...")
                }

                //self.bookingResponse = result
                print("result=\(result)")
                data = 99
                SSLCmzViewController.callback!(result)
                //isShownSSL = false

//                let swiftUIView = MyBooking() // swiftUIView is View
//                let viewCtrl1 = UIHostingController(rootView: swiftUIView)
//                self.navigationController?.pushViewController(viewCtrl1, animated: true)
            }
        }

//        data = 99
//        isShownSSL = false
//        sslCom = nil
    }
}


//struct SSLViewRepresentable: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
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


