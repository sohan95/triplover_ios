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
    
//    func searchFlightService(searchFlighRequest:SearchFlighRequest, completionHandler:@escaping(_ result: SearchedFlightResponse?)->Void) {
//        var urlRequest = URLRequest(url: URL(string: "http://52.221.202.198:83/api/Search")!)
//        urlRequest.httpMethod = "post"
//        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
//        urlRequest.httpBody = try? JSONEncoder().encode(searchFlighRequest)
//
//        URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error -> Void in
//            if (error == nil && data != nil) {
//
//                let responseData = try? JSONDecoder().decode(SearchedFlightResponse.self, from: data!)
//                //print(responseData)
//                _ = completionHandler(responseData)
//            }
//        }).resume()
//    }
    
    func searchFlightService(searchFlighRequest:SearchFlighRequest, completionHandler:@escaping(_ result: FlightSearchedDataModel?)->Void) {
        
        var urlRequest = URLRequest(url: URL(string: "http://52.221.202.198:83/api/Search")!)
        urlRequest.httpMethod = "post"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.httpBody = try? JSONEncoder().encode(searchFlighRequest)
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error -> Void in
            if (error == nil && data != nil) {
                
                let responseData = try? JSONDecoder().decode(FlightSearchedDataModel.self, from: data!)
                print(responseData!)
//                let responseData = try? newJSONDecoder().decode(SearchedFlightResponse.self, from: data!)
                _ = completionHandler(responseData)
            }
        }).resume()
    }
    
    func rePriceService(rePriceRequest:RePriceRequest, completionHandler:@escaping(_ result: RePriceResponse?)->Void) {
        let token = UserDefaults.standard.string(forKey: "token")
        guard let token = token else {
            return
        }

        var urlRequest = URLRequest(url: URL(string: "http://52.221.202.198:83/api/RePrice")!)
        urlRequest.httpMethod = "post"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"

        let encoder = JSONEncoder()
//        encoder.dateEncodingStrategy = .formatted(formatter)
        urlRequest.httpBody = try? encoder.encode(rePriceRequest)
        
        let encoder3 = JSONEncoder()
//        encoder3.dateEncodingStrategy = .millisecondsSince1970
        let myEventsJSONData = try! encoder3.encode(rePriceRequest)
        print(String(data: myEventsJSONData, encoding: .utf8)!)
        
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error -> Void in
            if (error == nil && data != nil) {
                
//                let json = try? JSONSerialization.jsonObject(with: data!) as? Dictionary<String, AnyObject>
//                print(json!)
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any]
                }catch{ print("erroMsg") }
                
//                let formatter = DateFormatter()
//                formatter.dateFormat = "yyyy-MM-dd"

//                let responseData = try? JSONDecoder().decode(BookingResponse.self, from: response)
//                print(responseData!)
                
                let decoder = JSONDecoder()
//                decoder.dateDecodingStrategy = .formatted(formatter)
                
                let responseData = try? decoder.decode(RePriceResponse.self, from: data!)
                print(responseData!)
//                let responseData = try? newJSONDecoder().decode(SearchedFlightResponse.self, from: data!)
                _ = completionHandler(responseData)
            }
        }).resume()
    }
    
    func bookingService(bookingRequest:BookingRequest, completionHandler:@escaping(_ result: BookingResponse?)->Void) {
        let token = UserDefaults.standard.string(forKey: "token")
        guard let token = token else {
            return
        }
        var urlRequest = URLRequest(url: URL(string: "http://52.221.202.198:83/api/BookB2C/AppBookingLog")!)
        urlRequest.httpMethod = "post"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(formatter)
        urlRequest.httpBody = try? encoder.encode(bookingRequest)
        
//        let encoder3 = JSONEncoder()
//        let myEventsJSONData = try! encoder3.encode(bookingRequest)
//        print(String(data: myEventsJSONData, encoding: .utf8)!)
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error -> Void in
            if (error == nil && data != nil) {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                    print(json)
                } catch {
                    print("error")
                }
                
                let decoder = JSONDecoder()
                let responseData = try? decoder.decode(BookingResponse.self, from: data!)
                print(responseData!)
//                let responseData = try? newJSONDecoder().decode(SearchedFlightResponse.self, from: data!)
                _ = completionHandler(responseData)
            }
        }).resume()
    }
    
    func bookingConfirm(bookingRequest:BookingRequest, completionHandler:@escaping(_ result: BookingResponse?)->Void) {
        let token = UserDefaults.standard.string(forKey: "token")
        guard let token = token else {
            return
        }
        var urlRequest = URLRequest(url: URL(string: "http://52.221.202.198:83/api/BookB2C/AppBookingLog")!)
        urlRequest.httpMethod = "post"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(formatter)
        urlRequest.httpBody = try? encoder.encode(bookingRequest)
        
//        let encoder3 = JSONEncoder()
//        let myEventsJSONData = try! encoder3.encode(bookingRequest)
//        print(String(data: myEventsJSONData, encoding: .utf8)!)
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error -> Void in
            if (error == nil && data != nil) {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                    print(json)
                } catch {
                    print("error")
                }
                
                let decoder = JSONDecoder()
                let responseData = try? decoder.decode(BookingResponse.self, from: data!)
                print(responseData!)
//                let responseData = try? newJSONDecoder().decode(SearchedFlightResponse.self, from: data!)
                _ = completionHandler(responseData)
            }
        }).resume()
    }
}

