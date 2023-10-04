//
//  FindFlightsController.swift
//  RyanairAutomation
//

import Foundation
import SwiftUI

enum InitialValue {
   case departure(AirportViewModel),
        destination(AirportViewModel),
        tripType(TripType),
        flightDate(String),
        returnFlightDate(String)
}

enum TripType {
   case oneway,
        round
}

enum AirportListState {
   case loading
   case done
}

@MainActor
class FindFlightsViewModel: ObservableObject {
   @Published var departure: AirportViewModel? = nil
   @Published var destination: AirportViewModel? = nil
   @Published var tripType: TripType = .oneway
   @Published var airportsList = [AirportViewModel]()
   @Published var flightDate: String?
   @Published var returnFlightDate: String?
   @Published var passengers = Passengers(adults: 1, teens: 0, children: 0, infants: 0)
   @Published var aiportListLoaded: AirportListState = .loading
   
   func setDepartureAiport(_ viewModel: AirportViewModel) {
      departure = viewModel
   }
   
   func setDestinationAirport(_ viewModel: AirportViewModel) {
      destination = viewModel
   }
   
   func isDepartureAirportSelected() -> Bool {
      return departure != nil
   }
   
   func changeFlightType(to type: TripType) {
      tripType = type
   }
   
   func setFlightDate(roundTrip: Bool, date: Date) {
      let newStringDate = date.toString()
      if roundTrip {
         returnFlightDate = newStringDate
         print("Flight return date: \(newStringDate)")
      } else {
         flightDate = newStringDate
         print("Flight date: \(newStringDate)")
      }
   }
   
   func setPassengerList(_ adults: Int, _ teens: Int, _ children: Int, _ infant: Int) {
      passengers = Passengers(adults: adults, teens: teens, children: children, infants: infant)
      print("New passenger list: \(passengers)")
   }
   
   func createAvailabilityRequest() -> FlightRequest {
      FlightRequest(
         departure: departure!.airport.code,
         destination: destination!.airport.code,
         passengers: passengers,
         tripType: tripType,
         date: flightDate!
      )
   }
   
   func reset() {
      tripType  = .oneway
      airportsList = [AirportViewModel]()
      returnFlightDate = nil
   }
    
    func getAirports() async {
        do {
           if airportsList.isEmpty {
              let airports: [Airport] = try await NetworkManager.fetch(Endpoints.airpots)
              airportsList = airports.map({ AirportViewModel(airport: $0) })
              aiportListLoaded = .done
           }
        } catch {
            print("Failed to get aiports list")
        }
    }
}


struct AirportViewModel: Identifiable {
   let airport: Airport
   let id = UUID()
}
