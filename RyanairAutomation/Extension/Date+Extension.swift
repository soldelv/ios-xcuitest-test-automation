//
//  Date+Extension.swift
//  RyanairAutomation
//

import Foundation

enum DateFormats: String {
   case dateTimeUtc = "yyyy-MM-dd'T'HH:mm:ss.SSS"
   case timeOnly = "HH:mm"
   case yearMonthDay = "yyyy-MM-dd"
   case dayOfWeekDayMonth = "E. d MMM"
}


extension Date {
   
   func toString(format: String = "yyyy-MM-dd") -> String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = format
      return dateFormatter.string(from: self)
   }
}
