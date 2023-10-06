//
//  FlightsPage.swift
//  RyanairAutomationUITests
//
//  Created by soldelv on 06/10/2023.
//

import Foundation
import XCTest

public class FlightsPage: BaseTest {
    
    //Page Elements
    lazy var okbtn = app.buttons["Ok"]
    
    //Page Methods
    @discardableResult
    func noFlightMessage(completion: Completion = nil)-> Self{
        XCTAssertTrue(app.staticTexts["No flights for this route."].exists)
        return self
    }
    
    @discardableResult
    func selectFirstAvailableFlight(completion: Completion = nil)-> Self{
        let predicate = NSPredicate(format: "label BEGINSWITH 'FR 84'")
        let element = app.staticTexts.element(matching: predicate).firstMatch
        element.tap()
        return self
    }
    
    @discardableResult
    func tripBookedMessage(completion: Completion = nil)-> Self{
        XCTAssertTrue(app.staticTexts["Trip booked"].exists)
        okbtn.tap()
        return self
    }
}

