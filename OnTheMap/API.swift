//
//  API.swift
//  OnTheMap
//
//  Created by Jimin Kim on 1/13/21.
//  Copyright © 2021 Jimin Kim. All rights reserved.
//

import Foundation

class API {
    
    struct Auth {
        static var userId = ""
        static var sessionId = ""
    }
    
    class func login(username: String, password: String, completion: @escaping(Bool, Error?) -> Void) {
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
        request.httpMethod = "POST"
        let body = LoginRequest(udacity: Udacity(username: username, password: password))
        request.httpBody = try! JSONEncoder().encode(body)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(false, error)
                }
                return
            }
            let range = (5..<data.count)
            let newData = data.subdata(in: range)
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(LoginResponse.self, from: newData)
                Auth.userId = responseObject.account.key
                Auth.sessionId = responseObject.session.id
                DispatchQueue.main.async {
                    completion(true, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(LoginErrorResponse.self, from: newData) as Error
                    DispatchQueue.main.async {
                        completion(false, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(false, error)
                    }
                }
            }
        }
        task.resume()
    }
    
    class func getStudentLocations(completion: @escaping([StudentLocation]?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: URL(string: "https://onthemap-api.udacity.com/v1/StudentLocation?limit=100&order=-updatedAt")!) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(StudentLocations.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject.results, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    class func getUser(completion: @escaping(User?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: URL(string: "https://onthemap-api.udacity.com/v1/users/\(Auth.userId)")!) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            let range = (5..<data.count)
            let newData = data.subdata(in: range)
            do {
                let responseObject = try decoder.decode(User.self, from: newData)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    class func postUser(firstName: String, lastName: String, mapString: String, mediaURL: String, latitude: Double, longitude: Double, completion: @escaping(Bool, Error?) -> Void) {
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/StudentLocation")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"\(Auth.userId)\", \"firstName\": \"\(firstName)\", \"lastName\": \"\(lastName)\",\"mapString\": \"\(mapString)\", \"mediaURL\": \"\(mediaURL)\",\"latitude\": \(latitude), \"longitude\": \(longitude)}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                DispatchQueue.main.async {
                    completion(false, error)
                }
            }
            DispatchQueue.main.async {
                completion(true, nil)
            }
        }
        task.resume()
    }
    
    
    var mapString: String?
    var mediaURL: String?
    var latitude: Double?
    var longitude: Double?
    
    class func logout(completion: @escaping () -> Void) {
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
          if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
          request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
          if error != nil { // Handle error…
              return
          }
            Auth.userId = ""
            Auth.sessionId = ""
            completion()
        }
        task.resume()
    }
    
    
    
    
}
