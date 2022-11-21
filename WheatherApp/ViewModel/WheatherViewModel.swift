//
//  WheatherViewModel.swift
//  WheatherApp
//
//  Created by Tushar  Jadhav on 2022-10-07.
//  Copyright © 2022 Shital  Jadhav. All rights reserved.
//

import Foundation

class WheatherViewModel {
  
  private let worker: WheatherForecastProtocol?

  var list: [Forecast] = []
  typealias WheatherFetchCompletionClosure = (_ response: (Result<String, DataResponseError>)) -> Void
  
  init(worker: WheatherForecastProtocol? = WheatherWorker()) {
     self.worker = worker
  }
  
  var totalCount: Int {
    return list.count
  }
  
  func forecast(at index: Int) -> Forecast? {
     if list.isEmpty {
       return nil
     }
     return list[index]
   }
  
  // MARK: - Fetch  Methods

  func getListOfCities(with plistName: String) -> [String]?
  {
    if let path = Bundle.main.path(forResource: plistName, ofType: "plist"),
      let xml = FileManager.default.contents(atPath: path)
    {
      return (try? PropertyListSerialization.propertyList(from: xml,
                                                          options: .mutableContainersAndLeaves,
                                                          format: nil)) as? [String]
    }
    
    return nil
  }
  
  // MARK: - API Call Methods
  
  func fetchForecastBy(cityName: String, forecastDate: String, _ completion: @escaping WheatherFetchCompletionClosure){
        
      self.worker?.fetchWheatherForecast(cityName: cityName) {[weak self] in
      
      guard let self = self else { return }
      
        switch $0 {
        case .success(let response):

          self.list = response.list.filter{ $0.dateStr.contains(forecastDate) }
          let name = String("\(response.city.name), \(response.city.country)")
          DispatchQueue.main.async {
            completion(.success(name))
          }
        case .failure(let error):
          DispatchQueue.main.async {
            completion(.failure(error))
          }
        }
      }
    }
}
