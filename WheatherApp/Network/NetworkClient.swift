//
//  NetworkClient.swift
//  WheatherApp
//
//  Created by Tushar  Jadhav on 2022-10-07.
//  Copyright © 2022 Shital  Jadhav. All rights reserved.
//

import Foundation

class NetworkClient {
  
  private lazy var baseDataURL: URL = {
     return URL(string: "https://api.openweathermap.org/data/2.5/")!
   }()

  lazy var imageBaseAPI: String = {
    return "https://openweathermap.org/img/wn/"
  }()

  private lazy var apiKey: String = {
    return ""
  }()
    
  private var newParameters = [String:String]()

  static let shared = NetworkClient()

  private init() {}

  // MARK: - API's

  enum APIName: String {
      case forecast = "forecast"
  }
  

  func performRequest<T: Decodable>(apiName: String, parameters:[String:String]?, _ completion: @escaping (Result<T, DataResponseError>) -> ()) {
        
    var urlRequest = URLRequest(url: baseDataURL.appendingPathComponent(apiName))
    urlRequest.httpMethod = "GET"
    
    if parameters != nil {
      newParameters = ["appid": "\(apiKey)"].merging(parameters!, uniquingKeysWith: +)
    } else {
      newParameters = ["appid": "\(apiKey)"]
    }
    
    let encodedURLRequest = urlRequest.encode(with: newParameters)
    
    URLSession.shared.dataTask(with: encodedURLRequest) { data, _, error in
      
      if let error = error {
        completion(.failure(.custom(error.localizedDescription)))
        return
      }
      
      guard let data = data else {
        completion(.failure(.custom("Failed to fetch data")))
        return
      }
      
      do {
        let decodedResponse = try JSONDecoder().decode(T.self, from: data)
        completion(.success(decodedResponse))
      } catch (_) {
        completion(.failure(.decoding))
      }
    }.resume()
    
    return
  }
  
}
