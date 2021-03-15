//
//  LoginErrorResponse.swift
//  OnTheMap
//
//  Created by Jimin Kim on 1/13/21.
//  Copyright © 2021 Jimin Kim. All rights reserved.
//

import Foundation

struct LoginErrorResponse: Codable {
    let status: Int
    let error: String
}

extension LoginErrorResponse: LocalizedError {
    var errorDescription: String? {
        return error
    }
}
