//
//  WheatherWorkerTests.swift
//  WheatherAppTests
//
//  Created by Tushar  Jadhav on 2022-10-10.
//  Copyright © 2022 Shital  Jadhav. All rights reserved.
//

import XCTest
@testable import WheatherApp


class WheatherWorkerTests: XCTestCase {
  
  var worker : WheatherWorker!
  var networkServiceSpy: NetworkClientSpy!
  
  override func setUp() {
    worker = WheatherWorker()
    networkServiceSpy = NetworkClientSpy()
    worker.networkClient = networkServiceSpy
  }
  
  override func tearDown() {
    networkServiceSpy = nil
    worker = nil
  }

  // MARK: - Fetch wheather forecast
  
   func testFetchWheatherForecastSucess() {
     
     let expectation = self.expectation(description: #function)
    
    //Given
    networkServiceSpy.result = Seeds.WheatherForecast.wheatherForecastData

    let cityName = "Stockholm"
    
    //When
    worker.fetchWheatherForecast(cityName: cityName){ result in
      
      //Then
      XCTAssertTrue(self.networkServiceSpy.performRequestCalled)
      
      switch result {
      case .failure(let error):
        XCTAssert(false, "Worker failed to fetch wheather forecast with given city \(error)")
      case .success(let response):
        XCTAssertEqual(response.city.name, cityName)
        XCTAssertEqual(response.list.count, 4)
      }
        
        expectation.fulfill()
    }
     
     wait(for: [expectation], timeout: 3)
   }
  
  func testFetchWheatherForecastFailed() {
    
    let expectation = self.expectation(description: #function)
   
   //Given
   networkServiceSpy.result = nil
   networkServiceSpy.error = .decoding

   let cityName = "Stockholm"
   
   //When
   worker.fetchWheatherForecast(cityName: cityName){ result in
     
     //Then
     XCTAssertTrue(self.networkServiceSpy.performRequestCalled)
     
     switch result {
     case .failure(let error):
       XCTAssert(true, "Worker failed to fetch wheather forecast with given city \(error)")
     case .success(let response):
       XCTAssertEqual(response.city.name, "")
       XCTAssertEqual(response.list.count, 0)
     }
       expectation.fulfill()
   }
    
    wait(for: [expectation], timeout: 3)
  }

}
