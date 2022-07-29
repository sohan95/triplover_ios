//
//  SSLCmzViewController.swift
//  flightexpert
//
//  Created by sohan on 7/26/22.
//

import Foundation
import UIKit
import SwiftUI
import SSLCommerzSDK

class SSLCmzViewController: UIViewController, SSLCommerzDelegate {
    @Published var delegate:SSLCommerzDelegate?
    @Published var sslCom: SSLCommerz?
    
    override func viewDidLoad() {
        print("viewDidLoad")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.initSSLCmz()
        }
        
    }
    
    func initSSLCmz(){
        sslCom = SSLCommerz.init(integrationInformation: .init(storeID: "tripl627f321a2eb5a", storePassword: "tripl627f321a2eb5a@ssl", totalAmount: 1000.00, currency: "BDT", transactionId: "TLL1626185596", productCategory: "TripLover"), emiInformation: nil, customerInformation:nil, shipmentInformation: nil, productInformation: nil, additionalInformation: nil)

        sslCom?.delegate = self
        sslCom?.start(in: self, shouldRunInTestMode: true)
    }
    
    func transactionCompleted(withTransactionData transactionData: TransactionDetails?) {
        //print(JSONSerializer.toJson(transactionData!))
        let ssl_response: Ssl_response = Ssl_response(aPIConnect: transactionData?.apiConnect, amount: transactionData?.amount, bank_tran_id: transactionData?.bank_tran_id, base_fair: transactionData?.base_fair, card_brand: transactionData?.card_brand, card_issuer: transactionData?.card_issuer, card_issuer_country: transactionData?.card_issuer_country, card_issuer_country_code: transactionData?.card_issuer_country_code, card_no: transactionData?.card_no, card_type: transactionData?.card_type, currency_amount: transactionData?.currency_amount, currency_rate: transactionData?.currency_rate, currency_type: transactionData?.currency_type, gw_version: transactionData?.gw_version, risk_level: transactionData?.risk_level, risk_title: transactionData?.risk_title, sessionsessionkey: transactionData?.sessionkey, status: transactionData?.status, store_amount: transactionData?.store_amount, tran_date: transactionData?.tran_date, tran_id: transactionData?.tran_id, val_id: transactionData?.val_id, validated_on: transactionData?.validated_on, value_a: transactionData?.value_a, value_b: transactionData?.value_b, value_c: transactionData?.value_c, value_d: transactionData?.value_d)
        
        var sslcmzRequest: SSLComerzResponse = SSLComerzResponse(uniqueTransID: transactionData?.tran_id, ssl_response: ssl_response)
        HttpUtility.shared.bookingConfirm(requestBody: sslcmzRequest) { result in

            DispatchQueue.main.async { [self] in
                //self.isBooking = false
                
                guard let result = result else {
                    return
                    //fatalError("There must be a problem decoding the data...")
                }
                
                //self.bookingResponse = result
                print(result)
            }
        }
        
//        data = 99
//        isShownSSL = false
//        sslCom = nil
    }
}
