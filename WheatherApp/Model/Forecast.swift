//
//  Forecast.swift
//  WheatherApp
//
//  Created by Tushar  Jadhav on 2022-10-07.
//  Copyright © 2022 Shital  Jadhav. All rights reserved.
//

import Foundation

struct Forecast: Decodable {
  var date: Int
  var main: Main
  var weather: [Weather]
  var visibility: Int
  var wind: Wind
  var dateStr: String
  
  enum CodingKeys: String, CodingKey {
    case weather
    case main
    case visibility
    case wind
    case date = "dt"
    case dateStr = "dt_txt"
  }
}

// MARK: - Main
struct Main: Codable {
    var temp: Double
    var feelsLike: Double
    var tempMin: Double
    var tempMax: Double
    var pressure: Int
    var humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }
}


// MARK: - Weather
struct Weather: Decodable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

// MARK: - Wind
struct Wind: Codable {
    var speed: Double
    var deg: Int
}
