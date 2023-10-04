//
//  AvailabilityRequest.swift
//  RyanairAutomation
//

import Foundation

class FlightRequest {
    var departureAirport: String
    var destinationAiport: String
    var adults: Int = 1
    var teens: Int = 0
    var children: Int = 0
    var infants: Int = 0
    var departureDate: String = ""
    var flexDaysBeforeOut: Int = 3
    
    init(departure: String, destination: String, passengers: Passengers, tripType: TripType, date: String) {
        departureAirport = departure
        destinationAiport = destination
        adults = passengers.adults
        teens = passengers.teens
        children = passengers.children
        infants = passengers.infants
        departureDate = date
    }
    
    var quaryString: String {
        get {
            "origin=\(departureAirport)&destination=\(destinationAiport)&dateout=\(departureDate)&flexdaysbeforeout=\(flexDaysBeforeOut)&adt=\(adults)&teen=\(teens)&chd=\(children)&inf=\(infants)&ToUs=AGREED"
        }
    }
    
}
