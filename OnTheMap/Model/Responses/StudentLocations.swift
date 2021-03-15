//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by Jimin Kim on 1/16/21.
//  Copyright © 2021 Jimin Kim. All rights reserved.
//

import Foundation

struct StudentLocations: Codable {
    let results: [StudentLocation]?
}

struct StudentLocation: Codable {
    let objectId: String?
    let uniqueKey: String?
    let firstName: String?
    let lastName: String?
    let mapString: String?
    let mediaURL: String?
    let latitude: Double?
    let longitude: Double?
    let updatedAt: String?
}
