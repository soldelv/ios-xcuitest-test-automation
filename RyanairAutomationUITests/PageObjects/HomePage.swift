//
//  HomePage.swift
//  RyanairAutomationUITests
//
//  Created by soldelv on 05/10/2023.
//

import Foundation
import XCTest

public class HomePage: BaseTest {
    override var rootElement: XCUIElement{
        return app.staticTexts["Book a flight"]
    }
    
    //Page Elements
    lazy var bookFlightBtn = app.staticTexts["Book a flight"]
    
    //Page Methods
    @discardableResult
    func checkHomePageIsdisplayed(completion: Completion = nil)-> Self{
        XCTAssertTrue(bookFlightBtn.exists)
        return self
    }
    
    @discardableResult
    func tapOnBookFlight(completion: Completion = nil)-> Self{
        log("tap Book a flight button")
        bookFlightBtn.tap()
        return self
    }
}

