//
//  Model.swift
//  RyanairAutomation
//

import Foundation

@MainActor
class Model: ObservableObject {
    
    @Published var availabilityState: AvailabilityState = .na
    var availabilityRequest: FlightRequest?
    var trip: Trip?
    var airports: [Airport]?
}

enum AvailabilityState {
    case na,
         loading,
         success,
         failed
}

extension Model {
    
    func updateAvailabilityRequest(params: FlightRequest) {
        availabilityRequest = params
    }
    
    func getAvailability() async {
        if let params = self.availabilityRequest {
            availabilityState = .loading
            print("Starting flight request")
            do {
                let flightReposne: FlightResponse = try await NetworkManager.fetch(Endpoints.availability + params.quaryString)
                let tripData = flightReposne.trips.first(where: {availabilityRequest?.departureAirport == $0.origin })!
                if tripData.dates.first(where: { !$0.flights.isEmpty }) != nil {
                    trip = tripData
                    availabilityState = .success
                    print(tripData)
                } else {
                    availabilityState = .failed
                }
            } catch {
                availabilityState = .failed
                print(error)
            }
        } else {
            availabilityState = .na
        }
    }
}
