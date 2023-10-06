//
//  BDDTest.swift
//  RyanairAutomationUITests
//
//  Created by soldelv on 06/10/2023.
//

import Foundation
import XCTest

class BDDTest: SearchTest {
    
    func testNoRouteForOneWayFlight() {
        GivenHomePageIsDisplayed()
        WhenSearchOneWayFlight()
        WhenSelectOrigin(fromDeparture: "Wroclaw, WRO")
        AndSelectDestination(toDestination: "Thessaloniki, SKG")
        AndDepartingNextWeek()
        AndThePassengersAre(passengers: (adults: 1, teens: 1, children: 0, infants: 1))
        AndConfirmsSearch()
        ThenNotSuchRouteMessageIsDisplayed()
    }
    
    func testAvailableReturnFlight() {
        GivenHomePageIsDisplayed()
        WhenSearchReturnFlight()
        WhenSelectOrigin(fromDeparture: "Wroclaw, WRO")
        AndSelectDestination(toDestination: "London Stansted, STN")
        AndDepartingNextMonth()
        AndThePassengersAre(passengers: (adults: 2, teens: 0, children: 2, infants: 0))
        AndConfirmsSearch()
        ThenAvailableFlightsMessageIsDisplayed()
    }
}
