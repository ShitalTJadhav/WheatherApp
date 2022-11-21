//
//  WheatherDetailsViewController.swift
//  WheatherApp
//
//  Created by Tushar  Jadhav on 2022-10-10.
//  Copyright © 2022 Shital  Jadhav. All rights reserved.
//

import UIKit

class WheatherDetailsViewController: UIViewController {
  
  @IBOutlet var tableView : UITableView?
  private let cellIdentifier = "WheatherDetailsId"
  
  var forecast: Forecast?
  var city: String = ""
  var dateStr: String = ""

  override func viewDidLoad() {
    super.viewDidLoad()
        
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
}

// MARK: - UITableView DataSource Delegate1 methods

extension WheatherDetailsViewController: UITableViewDataSource, UITableViewDelegate {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! WheatherDetailsCell
    cell.configureCell(city, dateStr: dateStr, forecast: forecast)
    return cell
  }

}
