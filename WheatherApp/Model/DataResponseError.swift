//
//  DataResponseError.swift
//  WheatherApp
//
//  Created by Tushar  Jadhav on 2022-10-07.
//  Copyright © 2022 Shital  Jadhav. All rights reserved.
//

import Foundation

enum DataResponseError: Error {
    case network
    case decoding
    case custom(String)

    var reason: String {
        switch self {
        case .network:
            return "An error occurred while fetching data"
        case .decoding:
            return "An error occurred while decoding json data"
        case .custom:
            return ""
        }
       
    }
}
