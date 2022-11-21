//
//  WheatherResponse.swift
//  WheatherApp
//
//  Created by Tushar  Jadhav on 2022-10-07.
//  Copyright © 2022 Shital  Jadhav. All rights reserved.
//

import Foundation

struct WheatherResponse: Decodable {
  
  let cod: String
  let list: [Forecast]
  let city: City
}

// MARK: - Coord
struct City: Decodable {
  
  let id: Int
  let name: String
  let coord: Coord
  let country: String
  let timezone: Int
  let sunrise: Int
  let sunset: Int
  
}

// MARK: - Coord
struct Coord: Decodable {
    var lon: Double
    var lat: Double
}
