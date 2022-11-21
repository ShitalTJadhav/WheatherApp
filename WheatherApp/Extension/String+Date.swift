//
//  String+Date.swift
//  WheatherApp
//
//  Created by Tushar  Jadhav on 2022-10-08.
//  Copyright © 2022 Shital  Jadhav. All rights reserved.
//

import Foundation

extension String {
    
    private func getDateFormatter(hasRelativeDate: Bool = false, dateFormat: String? = nil) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.doesRelativeDateFormatting = hasRelativeDate

        if let dateFormat = dateFormat
        {
            formatter.dateFormat = dateFormat
        }
        else {
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }
        return formatter
    }

    func getWheatherForecastDate(days: Int) -> String
    {
      
        let dateFormatter = getDateFormatter()
        let resultDate = Calendar.current.date(byAdding: .day, value: days, to: Date())
        
        if let resultDate = resultDate {
          dateFormatter.dateStyle = .short
          dateFormatter.dateFormat = "yyyy-MM-dd"
          return dateFormatterToString(dateFormatter,resultDate)
        }
        return self
    }
    
    func getWheatherDisplayDate() -> String  {
         
         let formatter = getDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
         guard let date = formatter.date(from: self) else {
             return ""
         }
         
         formatter.dateFormat = "EEEE, d MMM"

         let result:String = dateFormatterToString(formatter,date)
         return result
     }
  
    func getFormattedWheatherTime() -> String  {
        
        let formatter = getDateFormatter()
        guard let date = formatter.date(from: self) else {
            return ""
        }
        
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        formatter.dateFormat = "h a"
        let result:String = dateFormatterToString(formatter,date)
        return result
    }
    
    func dateFormatterToString(_ formatter: DateFormatter, _ date: Date) -> String {
        return formatter.string(from: date)
    }
}
