//
//  BaseTest.swift
//  RyanairAutomationUITests
//
//  Created by soldelv on 05/10/2023.
//

import XCTest

class Logger {
    func log(_ mlog: String){
        NSLog(mlog)
    }
}

public class BaseTest{
    typealias Completion = (() -> Void)?
    let app = XCUIApplication()
    let log = Logger().log
    
    var rootElement : XCUIElement{
        fatalError("subclass should override rootElement")
    }
    
    //Button
    func button(_ name: String) -> XCUIElement{
        return app.buttons[name]
    }
    
    //Navigation
    func navBar(_ name: String) -> XCUIElement{
        return app.navigationBars[name]
    }
    
    //Secure Field
    func secureField(_ name: String) -> XCUIElement{
        return app.secureTextFields[name]
    }
    
    //Text Field
    func textField(_ name: String) -> XCUIElement{
        return app.textFields[name]
    }
    
    //Text View
    func textView(_ name: String) -> XCUIElement{
        return app.textViews[name]
    }
    
    //Text
    func text(_ name: String) -> XCUIElement{
        return app.staticTexts[name]
    }
    
    func scrollToElement(_ element: XCUIElement) {
            while !element.exists || !element.isHittable {
                app.swipeUp()
            }
        }
    
    func formatDateToString(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let dateString = dateFormatter.date(from: date)
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = (Calendar.current.component(.day, from: dateString!) < 10) ? "EEEE, d MMMM" : "EEEE, dd MMMM"
        
        return outputDateFormatter.string(from: dateString!)
    }
    
    func getCurrentDayFormatted(completion: Completion = nil)-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let currentDate = Date()
        let dateString = formatDateToString(dateFormatter.string(from: currentDate))
        
        return dateString
    }
    
    func dateStringForNextWeek() -> String {
        let calendar = Calendar.current
        let currentDate = Date()
        
        if let nextWeekDate = calendar.date(byAdding: .day, value: 7, to: currentDate) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: nextWeekDate)
        } else {
            return "null"
        }
    }
    
    func dateStringForNextMonth() -> String {
        let calendar = Calendar.current
        let currentDate = Date()
        
        if let nextMonthDate = calendar.date(byAdding: .month, value: 1, to: currentDate) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: nextMonthDate)
        } else {
            return "null"
        }
    }
}
