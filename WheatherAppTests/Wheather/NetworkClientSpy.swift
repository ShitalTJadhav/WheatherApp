//
//  MockNetworkClient.swift
//  WheatherAppTests
//
//  Created by Tushar  Jadhav on 2022-10-10.
//  Copyright © 2022 Shital  Jadhav. All rights reserved.
//

import XCTest
@testable import WheatherApp

// MARK: - Mock Network class

class NetworkClientSpy: NetworkClient {
  
  var performRequestCalled : Bool = true
  var result:  Decodable?
  var error: DataResponseError = .network

  // MARK: Spied methods

  override func performRequest<T: Decodable>(apiName: String, parameters:[String:String]?, _ completion: @escaping (Result<T, DataResponseError>) -> ()) {
    
      performRequestCalled = true
    
    DispatchQueue.main.async {
      
      switch self.result {
      case .some(let result) where result as? T != nil:
        completion(.success(result as! T))
      default:
        completion(.failure(self.error))
      }
    }
  }
  
}
