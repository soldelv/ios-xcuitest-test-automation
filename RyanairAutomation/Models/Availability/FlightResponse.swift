//
//  AvailabilityRespone.swift
//  RyanairAutomation
//

import Foundation

struct FlightResponse: Codable {
    let trips: [Trip]
}

struct Trip: Codable {
    let origin: String
    let originName: String
    let destination: String
    let destinationName: String
    let tripType: String
    let dates: [FlightDates]
}

struct FlightDates: Codable {
    let dateOut: String
    let flights: [Flight]
}

struct Flight: Codable {
    let flightNumber: String
    let time: [String]
    let duration: String
    let operatedBy: String
}
