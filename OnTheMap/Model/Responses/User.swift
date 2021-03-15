//
//  User.swift
//  OnTheMap
//
//  Created by Jimin Kim on 3/11/21.
//  Copyright © 2021 Jimin Kim. All rights reserved.
//

import Foundation

struct User: Codable {
    let firstName: String?
    let lastName: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
