//
//  LoginResource.swift
//  flightexpert
//
//  Created by sohan on 5/19/22.
//

import Foundation

struct LoginResource {

    func authenticate(loginRequest: LoginRequest, completionHandler:@escaping(_ result: LoginResponse?)->Void) {

        var urlRequest = URLRequest(url: URL(string: "http://52.221.202.198:83/api/User/B2CAppLogin")!)
        urlRequest.httpMethod = "post"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.httpBody = try? JSONEncoder().encode(loginRequest)

        HttpUtility.shared.postData(request: urlRequest, resultType: LoginResponse.self) { response in
            _ = completionHandler(response)
        }
    }
    
    func signIn(loginRequest: LoginRequest, completionHandler:@escaping(_ result: LoginResponse?)->Void) {

        var urlRequest = URLRequest(url: URL(string: "https://api-dev-scus-demo.azurewebsites.net/api/User/Login")!)
        urlRequest.httpMethod = "post"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.httpBody = try? JSONEncoder().encode(loginRequest)

        HttpUtility.shared.postData(request: urlRequest, resultType: LoginResponse.self) { response in
            _ = completionHandler(response)
        }
    }

}
