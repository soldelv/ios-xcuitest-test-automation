//
//  SearchPage.swift
//  RyanairAutomationUITests
//
//  Created by soldelv on 05/10/2023.
//

import Foundation
import XCTest

public class SearchPage: BaseTest {
    
    //Page Elements
    lazy var oneWayBtn = app.buttons["One way"]
    lazy var returnBtn = app.buttons["Return"]
    lazy var fromWhereBtn = app.buttons["From, Where are you flying from?"]
    lazy var toWhereBtn = app.buttons["To, Where are you going?"]
    lazy var dateFlightBtn = app.buttons["Fly Out, Select Date"]
    lazy var selectDateBtn = app.buttons["Select date"]
    lazy var selectPassengersBtn = app.buttons["Passengers, 1 Adult (16+ years)"]
    lazy var confirmPassengersBtn = app.buttons["Confirm"]
    lazy var letsGoBtn = app.buttons["Let's go"]
    lazy var monthNextBtn = app.buttons["Month"]
    lazy var noRouteMessage = app.staticTexts["No flights for this route."]
    lazy var okbtn = app.buttons["Ok"]
    
    //Page Methods
    @discardableResult
    func tapOnOneWay(completion: Completion = nil)-> Self{
        log("Tap on One Way")
        oneWayBtn.tap()
        return self
    }
    
    @discardableResult
    func tapOnReturn(completion: Completion = nil)-> Self{
        log("Tap on Return")
        let exists = returnBtn.waitForExistence(timeout: 10)
        XCTAssert(exists, "Element not found")
        returnBtn.tap()
        return self
    }
    
    func tapOnConfirmSearch(completion: Completion = nil){
        log("Select date of flight")
        letsGoBtn.tap()
    }
    
    @discardableResult
    func noFlightMessage(completion: Completion = nil)-> Self{
        XCTAssertTrue(app.staticTexts["No flights for this route."].exists)
        return self
    }
    
    func selectFromFlight(fromDeparture: String){
        log("Tap on From button")
        fromWhereBtn.tap()
        
        log("Search and tap on "+fromDeparture)
        let departure = app.buttons[fromDeparture]
        scrollToElement(departure)
        departure.tap()
    }
    
    func selectToFlight(toDestination: String){
        log("Tap on Destination button")
        toWhereBtn.tap()
        
        log("Search and tap on "+toDestination)
        let destination = app.buttons[toDestination]
        scrollToElement(destination)
        destination.tap()
    }
    
    @discardableResult
    func tapOnFlightDate(completion: Completion = nil)-> Self{
        dateFlightBtn.tap()
        return self
    }
    
    @discardableResult
    func tapOnNextMonth(completion: Completion = nil)-> Self{
        let yourElement = app.buttons["Today, "+getCurrentDayFormatted()]
        let center = yourElement.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
        center.press(forDuration: 0.1, thenDragTo: center.withOffset(CGVector(dx: -100, dy: 0)))
        
        return self
    }
    
    func selectDateFlight(departureDate: String){
        let dateString = formatDateToString(departureDate)
        let dayLocator = app.buttons[dateString]
        dayLocator.tap()
        log("Tap on select date button")
        selectDateBtn.tap()
    }
    
    @discardableResult
    func tapOnPassengers(completion: Completion = nil)-> Self{
        log("Select passengers")
        selectPassengersBtn.tap()
    
        return self
    }
    
    func selectPassengersFlight(passengers: (adults: Int, teens: Int, children: Int, infants: Int)){
        
        if passengers.adults > 1 {
            log("Tap one more on Adults")
            app.buttons.matching(identifier: "Add").element(boundBy: 0).tap()
        }
        
        if passengers.teens > 0 {
            log("Select \(passengers.teens) Teens")
                for _ in 0..<passengers.teens {
                    app.buttons.matching(identifier: "Add").element(boundBy: 1).tap()
                }
        }
        
        if passengers.children > 0 {
            log("Select \(passengers.children) Infants")
                for _ in 0..<passengers.children {
                    app.buttons.matching(identifier: "Add").element(boundBy: 2).tap()
                }
        }
        
        if passengers.infants > 0 {
            log("Select \(passengers.infants) Infants")
                for _ in 0..<passengers.infants {
                    app.buttons.matching(identifier: "Add").element(boundBy: 3).tap()
                }
        }
        
        confirmPassengersBtn.tap()

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

