//
//  HttpUtility.swift
//  flightexpert
//
//  Created by sohan on 5/19/22.
//

import Foundation

final class HttpUtility {
    static let shared = HttpUtility()
    //static let baseUrl = "http://52.221.202.198:83/api"
    static let baseUrl = "http://54.169.108.46:81/api"
//    static let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6ImJzcnNvZnRiZEBnbWFpbC5jb20iLCJyb2xlIjoiQjJDIiwibmJmIjoxNjU2ODQzODc4LCJleHAiOjE2NTc0NDg2NzgsImlhdCI6MTY1Njg0Mzg3OH0.bqPW0mNAK7vRGpvBdUImdEmDqH2Z2MUL70EhrrrtjZs"
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
//        var request = URLRequest(url: URL(string: "\(HttpUtility.baseUrl)/User/B2CAppLogin")!)
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
//        var request = URLRequest(url: URL(string: "\(HttpUtility.baseUrl)/User/B2CRegister")!)
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
        var urlRequest = URLRequest(url: URL(string: "\(HttpUtility.baseUrl)/User/B2CAppLogin")!)
        urlRequest.httpMethod = "post"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.httpBody = try? JSONEncoder().encode(loginRequest)
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error -> Void in
            if (error == nil && data != nil) {
                
                let responseData = try? JSONDecoder().decode(LoginResponse.self, from: data!)
                //print(responseData!)
                _ = completionHandler(responseData)
            }
        }).resume()
    }
    
    func registerService(registerRequest: RegisterRequest, completionHandler:@escaping(_ result: RegisterResponse?)->Void) {
        var urlRequest = URLRequest(url: URL(string: "\(HttpUtility.baseUrl)/User/B2CRegister")!)
        urlRequest.httpMethod = "post"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.httpBody = try? JSONEncoder().encode(registerRequest)
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 300.0
        sessionConfig.timeoutIntervalForResource = 300.0
        let session = URLSession(configuration: sessionConfig)
        session.dataTask(with: urlRequest, completionHandler: { data, response, error -> Void in
            if (error == nil && data != nil) {
                
                let responseData = try? JSONDecoder().decode(RegisterResponse.self, from: data!)
                //print(responseData!)
                _ = completionHandler(responseData)
            }
        }).resume()
    }
    
//    func searchFlightService(searchFlighRequest:SearchFlighRequest, completionHandler:@escaping(_ result: SearchedFlightResponse?)->Void) {
//        var urlRequest = URLRequest(url: URL(string: "\(HttpUtility.baseUrl)/Search")!)
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
        
        var urlRequest = URLRequest(url: URL(string: "\(HttpUtility.baseUrl)/Search")!)
        urlRequest.httpMethod = "post"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.httpBody = try? JSONEncoder().encode(searchFlighRequest)
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 300.0
        sessionConfig.timeoutIntervalForResource = 300.0
        let session = URLSession(configuration: sessionConfig)

        session.dataTask(with: urlRequest, completionHandler: { data, response, error -> Void in
            if (error == nil && data != nil) {
                
                let responseData = try? JSONDecoder().decode(FlightSearchedDataModel.self, from: data!)
                // print(responseData!)
                // let responseData = try? newJSONDecoder().decode(SearchedFlightResponse.self, from: data!)
                _ = completionHandler(responseData)
            }
        }).resume()
    }
    
    func rePriceService(rePriceRequest:RePriceRequest, completionHandler:@escaping(_ result: RePriceResponse?)->Void) {
        let token = UserDefaults.standard.string(forKey: "token")
        guard let token = token else {
            return
        }
        print("token=\(token)")

        var urlRequest = URLRequest(url: URL(string: "\(HttpUtility.baseUrl)/RePrice")!)
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
        
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 300.0
        sessionConfig.timeoutIntervalForResource = 300.0
        let session = URLSession(configuration: sessionConfig)

        session.dataTask(with: urlRequest, completionHandler: { data, response, error -> Void in
            if (error == nil && data != nil) {
                
//                let json = try? JSONSerialization.jsonObject(with: data!) as? Dictionary<String, AnyObject>
//                print(json!)
                
                
//                do{
//                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any]
//                }catch{ print("erroMsg") }
                
//                let formatter = DateFormatter()
//                formatter.dateFormat = "yyyy-MM-dd"

//                let responseData = try? JSONDecoder().decode(BookingResponse.self, from: response)
//                print(responseData!)
                
                let decoder = JSONDecoder()
//                decoder.dateDecodingStrategy = .formatted(formatter)
                
                let responseData = try? decoder.decode(RePriceResponse.self, from: data!)
                
                //print(responseData!)
                _ = completionHandler(responseData)
            }
        }).resume()
    }
    
    func prepareBooking(requestBody:PrepareBookingRequest, completionHandler:@escaping(_ result: BookingResponse?)->Void) {
        let token = UserDefaults.standard.string(forKey: "token")
        guard let token = token else {
            return
        }
        var urlRequest = URLRequest(url: URL(string: "\(HttpUtility.baseUrl)/BookB2C/AppBookingLog")!)
        urlRequest.httpMethod = "post"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(formatter)
        urlRequest.httpBody = try? encoder.encode(requestBody)
        
//        let encoder3 = JSONEncoder()
//        let myEventsJSONData = try! encoder3.encode(requestBody)
//        print(String(data: myEventsJSONData, encoding: .utf8)!)
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 300.0
        sessionConfig.timeoutIntervalForResource = 300.0
        let session = URLSession(configuration: sessionConfig)

        session.dataTask(with: urlRequest, completionHandler: { data, response, error -> Void in
            if (error == nil && data != nil) {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                    print(json)
                } catch {
                    print("error")
                }
                
                let decoder = JSONDecoder()
                let responseData = try? decoder.decode(BookingResponse.self, from: data!)
                //print(responseData!)
//                let responseData = try? newJSONDecoder().decode(SearchedFlightResponse.self, from: data!)
                _ = completionHandler(responseData)
            }
        }).resume()
    }
    
    func bookingConfirm(requestBody:SSLComerzResponse, completionHandler:@escaping(_ result: BookingConfirmResponse?)->Void) {
        let token = UserDefaults.standard.string(forKey: "token")
        print(token)
        guard let token = token else {
            return
        }
        var urlRequest = URLRequest(url: URL(string: "\(HttpUtility.baseUrl)/BookB2C/AppBookingConfirm")!)
        urlRequest.httpMethod = "post"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(formatter)
        urlRequest.httpBody = try? encoder.encode(requestBody)
        
        let encoder3 = JSONEncoder()
        let myEventsJSONData = try! encoder3.encode(requestBody)
        print(String(data: myEventsJSONData, encoding: .utf8)!)
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 300.0
        sessionConfig.timeoutIntervalForResource = 300.0
        let session = URLSession(configuration: sessionConfig)

        session.dataTask(with: urlRequest, completionHandler: { data, response, error -> Void in
            if (error == nil && data != nil) {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                    print(json)
                } catch {
                    print("error")
                }
                
                let decoder = JSONDecoder()
                let responseData = try? decoder.decode(BookingConfirmResponse.self, from: data!)
                //print(responseData!)
//                let responseData = try? newJSONDecoder().decode(SearchedFlightResponse.self, from: data!)
                _ = completionHandler(responseData)
            }
        }).resume()
    }
    
    func AirTicketing(requestBody:AirTicketingRequest, completionHandler:@escaping(_ result: [AirTicketingResponse]?)->Void) {
        let token = UserDefaults.standard.string(forKey: "token")
        guard let token = token else {
            return
        }
        
        var urlRequest = URLRequest(url: URL(string: "\(HttpUtility.baseUrl)/ReportB2C/AirTicketing")!)
        urlRequest.httpMethod = "post"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"

        let encoder = JSONEncoder()
//        encoder.dateEncodingStrategy = .formatted(formatter)
        urlRequest.httpBody = try? encoder.encode(requestBody)
        
//        let encoder3 = JSONEncoder()
//        let myEventsJSONData = try! encoder3.encode(requestBody)
//        print(String(data: myEventsJSONData, encoding: .utf8)!)
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 300.0
        sessionConfig.timeoutIntervalForResource = 300.0
        let session = URLSession(configuration: sessionConfig)

        session.dataTask(with: urlRequest, completionHandler: { data, response, error -> Void in
            if (error == nil && data != nil) {

                        
//                do {
////                    let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
//                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: Any]
//                    print(json)
//                } catch {
//                    print("error")
//                }
                
//                NSString *responseString = [[NSString, alloc] initWithData:data encoding:NSUTF8StringEncoding];
//
//                 NSLog(@"Response: %@",responseString);
//
//
//                 NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
//
//                 id json = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
                
                
                let decoder = JSONDecoder()
                let responseData = try? decoder.decode([AirTicketingResponse].self, from: data!)
                //print(responseData!)
//                let responseData = try? newJSONDecoder().decode(SearchedFlightResponse.self, from: data!)
                _ = completionHandler(responseData)
            }
        }).resume()
    }
    
    func getAirTicketingDetails(ticketId:String, completionHandler:@escaping(_ result: AirTicketingDetailsResponse?)->Void) {
        let token = UserDefaults.standard.string(forKey: "token")
        guard let token = token else {
            return
        }
        var urlRequest = URLRequest(url: URL(string: "\(HttpUtility.baseUrl)/ReportB2C/AirTicketingDetails/\(ticketId)")!)
        urlRequest.httpMethod = "get"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 300.0
        sessionConfig.timeoutIntervalForResource = 300.0
        let session = URLSession(configuration: sessionConfig)

        session.dataTask(with: urlRequest, completionHandler: { data, response, error -> Void in
            if (error == nil && data != nil) {
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
//                    print(json)
//                } catch {
//                    print("error")
//                }
                
                let decoder = JSONDecoder()
                let responseData = try? decoder.decode(AirTicketingDetailsResponse.self, from: data!)
                // print(responseData!)
//                let responseData = try? newJSONDecoder().decode(SearchedFlightResponse.self, from: data!)
                _ = completionHandler(responseData)
            }
        }).resume()
    }
}

