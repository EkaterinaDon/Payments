//
//  LoginModel.swift
//  payments
//
//  Created by Ekaterina on 2.07.21.
//

import Foundation

struct Login: Codable {
    let success: String
    let response: Response
}

struct Response: Codable {
    let token: String
}
