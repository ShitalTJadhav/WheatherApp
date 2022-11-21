//
//  WheatherDetailsCell.swift
//  WheatherApp
//
//  Created by Tushar  Jadhav on 2022-10-10.
//  Copyright © 2022 Shital  Jadhav. All rights reserved.
//


import UIKit

class WheatherDetailsCell: UITableViewCell {
  
  @IBOutlet var bgView: UIView?
  @IBOutlet var cityNameLabel: UILabel?
  @IBOutlet var dateLabel: UILabel?
  @IBOutlet var timeLabel: UILabel?
  @IBOutlet var tempLabel: UILabel?
  @IBOutlet var descriptionLabel: UILabel?
  @IBOutlet var iconImageView: UIImageView?
  @IBOutlet var reelFeelLabel: UILabel?
  @IBOutlet var windLabel: UILabel?
  @IBOutlet var humidityLabel: UILabel?

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    bgView?.layer.cornerRadius = 12
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
  // MARK: - configure cell

  func configureCell(_ city: String, dateStr: String, forecast: Forecast?) {
    
    guard let forecast = forecast else {
      return
    }
    
    cityNameLabel?.text = city
    dateLabel?.text = dateStr
    timeLabel?.text = forecast.dateStr.getFormattedWheatherTime()
    tempLabel?.text = String(format: "%.0f °", forecast.main.temp)
    humidityLabel?.text = String(forecast.main.humidity).appendingFormat("%@", "%")
    reelFeelLabel?.text = String(format: "%.0f °", forecast.main.feelsLike)
    windLabel?.text = String(forecast.wind.speed)

    descriptionLabel?.text = forecast.weather.first?.description
    
    guard let imageStr = forecast.weather.first?.icon, let imageUrl = NSURL(string: String("\(NetworkClient.shared.imageBaseAPI)\(imageStr)@2x.png")) as URL? else {
      iconImageView?.image = UIImage(named: "placeholder-icon")
      return
    }
    
    downloadImage(from: imageUrl)
  }
  
  // MARK: - Download Image

  func downloadImage(from url: URL) {
      getData(from: url) { data, response, error in
          guard let data = data, error == nil else { return }
          DispatchQueue.main.async() { [weak self] in
            self?.iconImageView?.image = UIImage(data: data)
          }
      }
  }

  func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
      URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
  }
  
}
