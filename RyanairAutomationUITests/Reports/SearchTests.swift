//
//  SearchTests.swift
//  RyanairAutomationUITests
//
//  Created by soldelv on 05/10/2023.
//

import XCTest

class SearchTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testNoRouteForOneWayFlight() {
        HomePage()
            .tapOnBookFlight()
        
        SearchPage()
            .tapOnOneWay()
            .selectFromFlight(fromDeparture: "Wroclaw, WRO")
        
        SearchPage().selectToFlight(toDestination: "Thessaloniki, SKG")
        
        SearchPage()
            .tapOnFlightDate()
            .selectDateFlight(departureDate: "2023-10-12")
        
        SearchPage()
            .tapOnPassengers()
            .selectPassengersFlight(passengers: (adults: 1, teens: 1, children: 0, infants: 1))
        
        SearchPage().tapOnConfirmSearch()
        
        FlightsPage().noFlightMessage()
    }
    
    func testAvailableReturnFlight() {
        HomePage()
            .tapOnBookFlight()
        
        SearchPage()
            .tapOnReturn()
            .selectFromFlight(fromDeparture: "Wroclaw, WRO")
        
        SearchPage().selectToFlight(toDestination: "London Stansted, STN")
            
        SearchPage()
            .tapOnFlightDate()
            .tapOnNextMonth()
        
        SearchPage().selectDateFlight(departureDate: "2023-11-12")
        
        SearchPage()
            .tapOnPassengers()
            .selectPassengersFlight(passengers: (adults: 2, teens: 0, children: 2, infants: 0))
        
        SearchPage()
            .tapOnConfirmSearch()
            
        FlightsPage()
            .selectFirstAvailableFlight()
            .tripBookedMessage()
    }

}
