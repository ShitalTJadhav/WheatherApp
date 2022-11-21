//
//  WheatherViewModelTests.swift
//  WheatherAppTests
//
//  Created by Tushar  Jadhav on 2022-10-10.
//  Copyright © 2022 Shital  Jadhav. All rights reserved.
//

import XCTest
@testable import WheatherApp


class WheatherViewModelTests: XCTestCase {
  
  var fetchWheatherForecastCalled : Bool = true
  var viewModel : WheatherViewModel!
  var workerSpy: WheatherWorkerSpy!

  
  override func setUp() {
    
    workerSpy = WheatherWorkerSpy()
    viewModel = WheatherViewModel(worker: workerSpy)
  }
  
  override func tearDown() {
    workerSpy = nil
    viewModel = nil
  }

  // MARK: - Mock Worker class

  class WheatherWorkerSpy: WheatherForecastProtocol {
    
    var fetchWheatherCalled : Bool = true
    var response: WheatherResponse = Seeds.WheatherForecast.wheatherForecastData
    var error: DataResponseError?
    
      
    func fetchWheatherForecast(cityName: String,
                         _ completion: @escaping (_ response: (Result<WheatherResponse, DataResponseError>)) -> Void){

      fetchWheatherCalled = true
      
      guard let error = error else {
        completion(.success(response))
        return
      }
      completion(.failure(error))
    }
  }

  
  // MARK: - Fetch wheather forecast
  
  func testCitiesList() {
      
    guard let list = self.viewModel?.getListOfCities(with: "Cities") else {
        return
    }
    XCTAssertEqual(list.count, 6, "")
  }
  
   func testFetchForecastOnReceiveSucess() {
     
     let expectation = self.expectation(description: #function)
    
    //Given
    workerSpy.error = nil
    workerSpy.fetchWheatherCalled = false
    let forecastDate = "2022-10-11"

    //When
    self.viewModel.fetchForecastBy(cityName: "Stockholm", forecastDate: forecastDate){ result in
      
      //Then
      XCTAssertTrue(self.workerSpy.fetchWheatherCalled)

      switch result {
      case .failure(let error):
        XCTAssert(false, "Received error while fetching wheather forecast with given city - \(error)")
      case .success(let cityName):
        XCTAssertEqual(cityName, "Stockholm, SE")
        XCTAssertEqual(self.viewModel.list.count, 2)
      }
        expectation.fulfill()
    }
     
     wait(for: [expectation], timeout: 3)
   }

  func testFetchForecastOnReceiveError() {
    
    let expectation = self.expectation(description: #function)
    
    //Given
    workerSpy.error = .decoding
    workerSpy.fetchWheatherCalled = false
    let forecastDate = "2022-10-11"
    
    //When
    self.viewModel.fetchForecastBy(cityName: "Stockholm", forecastDate: forecastDate){ result in
      
      //Then
      XCTAssertTrue(self.workerSpy.fetchWheatherCalled)
      
      switch result {
      case .failure(let error):
        XCTAssert(true, "Received error while fetching wheather forecast with given city - \(error)")
      case .success(let cityName):
        XCTAssertEqual(cityName, "")
        XCTAssertEqual(self.viewModel.list.count, 0)
      }
        expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 3)
  }
}
