//
//  SearchTest.swift
//  RyanairAutomationUITests
//
//  Created by mac on 06/10/2023.
//

import Foundation
import XCTest

class SearchTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func GivenHomePageIsDisplayed() {
        XCTContext.runActivity(named: "Given home page is displayed ") { _ in
            XCTAssertTrue(HomePage().bookFlightBtn.exists)
        }
    }
    
    func WhenSearchOneWayFlight() {
        XCTContext.runActivity(named: "When search one way flight ") { _ in
            HomePage().tapOnBookFlight()
            SearchPage().tapOnOneWay()
        }
    }
    
    func WhenSearchReturnFlight() {
        XCTContext.runActivity(named: "When search return flight ") { _ in
            HomePage().tapOnBookFlight()
            SearchPage().tapOnReturn()
        }
    }
    
    func AndDepartingNextWeek() {
        XCTContext.runActivity(named: "And departing next week ") { _ in
            SearchPage()
                .tapOnFlightDate()
                .selectDateFlight(departureDate: SearchPage().dateStringForNextWeek())
        }
    }

    func AndDepartingNextMonth() {
        XCTContext.runActivity(named: "And departing next month ") { _ in
            SearchPage()
                .tapOnFlightDate()
                .tapOnNextMonth()

            SearchPage().selectDateFlight(departureDate: SearchPage().dateStringForNextMonth())
        }
    }
    
        
    func AndThePassengersAre(passengers: (adults: Int, teens: Int, children: Int, infants: Int)) {
        XCTContext.runActivity(named: "And passengers are \(passengers.adults) adults \(passengers.teens) teens \(passengers.children) children  \(passengers.infants) infants  ") { _ in
                
                SearchPage()
                    .tapOnPassengers()
                    .selectPassengersFlight(passengers: (adults: passengers.adults, teens: passengers.teens, children: passengers.children, infants: passengers.infants))
            }
        }
    
    func WhenSelectOrigin(fromDeparture: String) {
        XCTContext.runActivity(named: "When departure from \(fromDeparture) ") { _ in
            SearchPage().selectFromFlight(fromDeparture: fromDeparture)
        }
    }
    
    func AndSelectDestination(toDestination: String) {
        XCTContext.runActivity(named: "And destination to \(toDestination) ") { _ in
            SearchPage().selectToFlight(toDestination: toDestination)
        }
    }
    
    func AndConfirmsSearch() {
        XCTContext.runActivity(named: "And confirms search") { _ in
            SearchPage().tapOnConfirmSearch()
        }
    }
    
    func ThenNotSuchRouteMessageIsDisplayed() {
        XCTContext.runActivity(named: "Then not such route message is displayed ") { _ in
            XCTAssertTrue(SearchPage().noRouteMessage.exists)
        }
    }
    
    func ThenAvailableFlightsMessageIsDisplayed(){
        XCTContext.runActivity(named: "Then available flights message is displayed ") { _ in
            FlightsPage()
                .selectFirstAvailableFlight()
                .tripBookedMessage()
        }
    }
        
    
}
