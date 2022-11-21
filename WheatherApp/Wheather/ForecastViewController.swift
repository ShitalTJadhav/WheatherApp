//
//  ForecastViewController.swift
//  WheatherApp
//
//  Created by Tushar  Jadhav on 2022-10-07.
//  Copyright © 2022 Shital  Jadhav. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {
  

  @IBOutlet var tableView : UITableView?
  @IBOutlet var cityNameText : UILabel?
  @IBOutlet var dateLabel : UILabel?
  private let cellIdentifier = "WheatherCellIdentifier"
  private let detailVCIdentifier = "WheatherDetailsViewController"

  var cityName: String = ""
  var citiesArray: [String] = []

  private lazy var viewModel : WheatherViewModel = {
    let viewModel = WheatherViewModel()
    return viewModel
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.fetchCities()
    
    setupTableView()
  }
  
  // MARK: - Private methods
   private func setupTableView(){
     guard let tableView = tableView else {
       return
     }
     
     tableView.dataSource = self
     tableView.delegate = self
   }
  
    private func fetchCities(){
        
        if let list = viewModel.getListOfCities(with: "Cities"), list.isEmpty {
            
            citiesArray = list
            
            //Fetch wheather forecast with some default city
            cityName = citiesArray.first ?? ""
            
            fetchWheatherForecast()
        }
    }
  

  private func fetchWheatherForecast(){
    
    //Fetch tommorow's forcast
    var forecastDate: String = ""
    forecastDate = forecastDate.getWheatherForecastDate(days: 1)

    viewModel.fetchForecastBy(cityName: cityName, forecastDate: forecastDate){ [weak self] result in
      switch result {
      case .failure: break
      case .success(let location):
        self?.cityNameText?.text = location
        self?.dateLabel?.text = forecastDate.getWheatherDisplayDate()
        self?.tableView?.reloadData()
      }
    }
  }
  
  @IBAction func chooseAnotherCityButtonTapped(_ sender: UIButton) {
    
    let alert = UIAlertController(title: "Select city", message: "To see weather forecast", preferredStyle: .alert)
    
    //Show list of cities on alertview
    for name in citiesArray {
      
      let alertButton = UIAlertAction(title: name, style: .default, handler: { action in
        self.cityName = action.title ?? ""

        //Update wheather forecast for selected city
        self.fetchWheatherForecast()
      })
      alert.addAction(alertButton)
    }
    
    let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    alert.addAction(cancel)
    
    DispatchQueue.main.async(execute: {
      self.present(alert, animated: true)
    })
  }
  
}

// MARK: - UITableView DataSource Delegate methods

extension ForecastViewController: UITableViewDataSource, UITableViewDelegate {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.totalCount
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! WheatherListCell
    cell.configureCell(viewModel.forecast(at: indexPath.row))
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = storyboard?.instantiateViewController(withIdentifier: detailVCIdentifier) as? WheatherDetailsViewController
    vc?.city = self.cityNameText?.text ?? cityName
    vc?.dateStr = self.dateLabel?.text ?? ""
    vc?.forecast = self.viewModel.forecast(at: indexPath.row)
    navigationController?.pushViewController(vc!, animated: true)
  }

}
