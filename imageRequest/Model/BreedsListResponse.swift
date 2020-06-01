//
//  BreedsListResponse.swift
//  imageRequest
//
//  Created by George Solorio on 6/1/20.
//  Copyright © 2020 George Solorio. All rights reserved.
//

import Foundation

struct BreedsListResponse: Codable {
    let status: String
    let message: [String: [String]]
}
