//
//  AvailabilityRequest.swift
//  RyanairAutomation
//

import Foundation

class AvailabilityRequest {
   var departureAirport: String
   var destinationAiport: String
   var adults: Int = 1
   var teens: Int = 0
   var children: Int = 0
   var infants: Int = 0
   var roundTrip: String = "false"
   var departureDate: String = ""
   var flexDaysBeforeOut: Int = 5
   
   init(departure: String, destination: String, passengers: Passengers, tripType: TripType, date: String) {
      departureAirport = departure
      destinationAiport = destination
      adults = passengers.adults
      teens = passengers.teens
      children = passengers.children
      infants = passengers.infants
      roundTrip = tripType == .oneway ? "false" : "true"
      departureDate = date
   }
   
   var quaryString: String {
      get {
         let queryString = "?origin=\(departureAirport)&destination=\(destinationAiport)&dateout=\(departureDate)&flexdaysbeforeout=\(flexDaysBeforeOut)&adt=\(adults)&teen=\(teens)&chd=\(children)&inf=\(infants)&roundtrip=\(roundTrip)&ToUs=AGREED"
         
         return queryString
      }
   }
   
}
