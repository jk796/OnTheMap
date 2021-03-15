//
//  LoginRequest.swift
//  OnTheMap
//
//  Created by Jimin Kim on 1/13/21.
//  Copyright © 2021 Jimin Kim. All rights reserved.
//

import Foundation

struct LoginRequest: Codable {
    let udacity: Udacity
}

struct Udacity: Codable {
    let username: String
    let password: String
}
