//
//  Seeds.swift
//  WheatherAppTests
//
//  Created by Tushar  Jadhav on 2022-10-12.
//  Copyright © 2022 Shital  Jadhav. All rights reserved.
//

import Foundation
@testable import WheatherApp

struct Seeds {
  
  struct WheatherForecast {
    
    static let wheatherForecastData : WheatherResponse = WheatherResponse(cod: "200",
                                                                          list: [Forecast(date: 1665327600,
                                                                                          main: Main(temp: 284.97, feelsLike: 283.72, tempMin: 284.78, tempMax: 284.97, pressure: 1016, humidity: 58),
                                                                                          weather: [Weather(id: 802,
                                                                                                            main: "Rain",
                                                                                                            description: "Light rain",
                                                                                                            icon: "03d")],
                                                                                          visibility: 10000,
                                                                                          wind: Wind(speed: 4.1, deg:224),
                                                                                          dateStr: "2022-10-10 12:00:00"),
                                                                                 Forecast(date: 1665327600,
                                                                                          main: Main(temp: 284.97, feelsLike: 283.72, tempMin: 284.78, tempMax: 284.97, pressure: 1016, humidity: 58),
                                                                                          weather: [Weather(id: 802,
                                                                                                            main: "Clouds",
                                                                                                            description: "scattered clouds",
                                                                                                            icon: "03d")],
                                                                                          visibility: 10000,
                                                                                          wind: Wind(speed: 4.1, deg:224),
                                                                                          dateStr: "2022-10-10 15:00:00"),
                                                                                 Forecast(date: 1665327600,
                                                                                          main: Main(temp: 284.97, feelsLike: 283.72, tempMin: 284.78, tempMax: 284.97, pressure: 1016, humidity: 58),
                                                                                          weather: [Weather(id: 802,
                                                                                                            main: "Rain",
                                                                                                            description: "Light rain",
                                                                                                            icon: "03d")],
                                                                                          visibility: 10000,
                                                                                          wind: Wind(speed: 4.1, deg:224),
                                                                                          dateStr: "2022-10-11 9:00:00"),
                                                                                 Forecast(date: 1665327600,
                                                                                          main: Main(temp: 284.97, feelsLike: 283.72, tempMin: 284.78, tempMax: 284.97, pressure: 1016, humidity: 58),
                                                                                          weather: [Weather(id: 802,
                                                                                                            main: "Rain",
                                                                                                            description: "Light rain",
                                                                                                            icon: "03d")],
                                                                                          visibility: 10000,
                                                                                          wind: Wind(speed: 4.1, deg:224),
                                                                                          dateStr: "2022-10-11 12:00:00")],
                                                                          city: City(id: 2673723, name: "Stockholm", coord: Coord(lon: 18.0, lat: 58.8), country: "SE", timezone: 7200, sunrise: 798, sunset: 746))
  }
  
}
