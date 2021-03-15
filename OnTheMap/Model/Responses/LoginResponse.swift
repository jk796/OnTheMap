//
//  LoginResponse.swift
//  OnTheMap
//
//  Created by Jimin Kim on 1/13/21.
//  Copyright © 2021 Jimin Kim. All rights reserved.
//

import Foundation

struct LoginResponse: Codable {
    let account: Account
    let session: Session
}

struct Account: Codable {
    let registered: Bool
    let key: String
}

struct Session: Codable {
    let id: String
    let expiration: String
}
