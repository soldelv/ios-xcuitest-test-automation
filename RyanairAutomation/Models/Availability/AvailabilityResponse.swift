//
//  AvailabilityRespone.swift
//  RyanairAutomation
//

import Foundation

struct AvailabilityResponse: Codable {
   var trips: [TripResponse]
}

struct TripResponse: Codable {
   var origin: String
   var originName: String
   var destination: String
   var destinationName: String
   var tripType: String
   var dates: [FlightDateResponse]
}
 
struct FlightDateResponse: Codable {
   var dateOut: String
   var flights: [FlightInfoResponse]
}

struct FlightInfoResponse: Codable {
   var flightNumber: String
   var time: [String]
   var duration: String
   var operatedBy: String
}
