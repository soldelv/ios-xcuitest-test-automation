//
//  String+Extension.swift
//  RyanairAutomation
//

import Foundation

extension String {
   
   func toString(inputFormat: DateFormats, outputFormat: DateFormats) -> String {
      let formatter = DateFormatter()
      formatter.dateFormat = inputFormat.rawValue
      let date = formatter.date(from: self)!
      formatter.dateFormat = outputFormat.rawValue
      return formatter.string(from: date)
   }
   
}
