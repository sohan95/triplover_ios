//
//  HttpUtility.swift
//  flightexpert
//
//  Created by sohan on 5/19/22.
//

import Foundation
final class HttpUtility {
    static let shared = HttpUtility()
    private init(){}
    
    func postData<T:Decodable>(request: URLRequest, resultType:T.Type, completionHandler:@escaping(_ reuslt: T?)-> Void) {

        URLSession.shared.dataTask(with: request) { data, response, error in
            if(error == nil && data != nil) {
                
                let response = try? JSONDecoder().decode(resultType.self, from: data!)
                _ = completionHandler(response)
            }
        }.resume()
    }
    
//    func login() {
//        let params = ["email":"akash71khan@gmail.com", "password":"123456", "deviceId":"123456"] as Dictionary<String, String>
//
//        var request = URLRequest(url: URL(string: "http://52.221.202.198:83/api/User/B2CAppLogin")!)
//        request.httpMethod = "POST"
//        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let session = URLSession.shared
//        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
//            print(response!)
//            do {
//                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
//                let response = try? JSONDecoder().decode(SigninResponse.self, from: data!)
//                print(json)
//            } catch {
//                print("error")
//            }
//        })
//
//        task.resume()
//    }
    
//    func register() {
//        let params = ["fullName": "akash1", "mobile": "01722599915", "email": "akash71khan@gmail.com", "password": "123456", "confirmPassword": "123456"] as Dictionary<String, String>
//
//        var request = URLRequest(url: URL(string: "http://52.221.202.198:83/api/User/B2CRegister")!)
//        request.httpMethod = "POST"
//        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let session = URLSession.shared
//        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
//            print(response!)
//            do {
//                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
//                //let response = try? JSONDecoder().decode(SigninResponse.self, from: data!)
//                print(json)
//            } catch {
//                print("error")
//            }
//        })
//
//        task.resume()
//    }
    
    func loginService(loginRequest:LoginRequest, completionHandler:@escaping(_ result: LoginResponse?)->Void) {
        var urlRequest = URLRequest(url: URL(string: "http://52.221.202.198:83/api/User/B2CAppLogin")!)
        urlRequest.httpMethod = "post"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.httpBody = try? JSONEncoder().encode(loginRequest)
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error -> Void in
            if (error == nil && data != nil) {
                
                let responseData = try? JSONDecoder().decode(LoginResponse.self, from: data!)
                print(responseData!)
                _ = completionHandler(responseData)
            }
        }).resume()
    }
    
    func registerService(registerRequest: RegisterRequest, completionHandler:@escaping(_ result: RegisterResponse?)->Void) {
        var urlRequest = URLRequest(url: URL(string: "http://52.221.202.198:83/api/User/B2CRegister")!)
        urlRequest.httpMethod = "post"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.httpBody = try? JSONEncoder().encode(registerRequest)
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error -> Void in
            if (error == nil && data != nil) {
                
                let responseData = try? JSONDecoder().decode(RegisterResponse.self, from: data!)
                print(responseData!)
                _ = completionHandler(responseData)
            }
        }).resume()
    }
    
    func searchFlightService(searchFlighRequest:SearchFlighRequest, completionHandler:@escaping(_ result: FlightSearchedDataModel?)->Void) {
        var urlRequest = URLRequest(url: URL(string: "http://52.221.202.198:83/api/Search")!)
        urlRequest.httpMethod = "post"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.httpBody = try? JSONEncoder().encode(searchFlighRequest)
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error -> Void in
            if (error == nil && data != nil) {
                
                let responseData = try? JSONDecoder().decode(FlightSearchedDataModel.self, from: data!)
                print(responseData!)
                _ = completionHandler(responseData)
            }
        }).resume()
    }
}

