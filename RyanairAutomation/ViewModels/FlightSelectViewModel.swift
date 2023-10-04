//
//  FlightSelectViewModel.swift
//  RyanairAutomation
//

import Foundation

enum FlightDirection {
    case outbound, inbound
}

class FlightSelectViewModel: ObservableObject {
    @Published var flightDateList = [FlightDateViewModel]()
    
    func updateModel(with trip: Trip?) {
        guard let tripData = trip else { return }
        let flightDateListVM = FlightDateListViewModel(trip: tripData)
        flightDateListVM.flights[..<3].forEach({ flightDateList.append($0) })
        let index = flightDateList.firstIndex(where: { $0.flights.count > 0})!
        flightDateList[index].isSelected = true
    }
    
    func selectNewDate(id: UUID) {
        let selectedDateIndex = flightDateList.firstIndex(where: { $0.isSelected == true })!
        flightDateList[selectedDateIndex].toggleSelectState()
        let newDateIndex = flightDateList.firstIndex(where: { $0.id == id })!
        flightDateList[newDateIndex].toggleSelectState()
    }
    
    func getFlightByDate() -> [FlightCardViewModel] {
        return flightDateList.filter({ $0.isSelected == true}).first!.flights
    }
}

struct FlightDateListViewModel {
    var flights: [FlightDateViewModel]
    
    init(trip: Trip) {
        flights = trip.dates.map {
            FlightDateViewModel(
                departureAiport: trip.origin,
                destinationAirport: trip.destination,
                flightdate: $0.dateOut,
                flightInfo: $0.flights
            )
        }
    }
}

struct FlightDateViewModel: Identifiable {
    var id = UUID()
    var dateOut: String
    var flights: [FlightCardViewModel]
    var isSelected: Bool = false
    
    init(departureAiport: String, destinationAirport: String, flightdate: String, flightInfo: [Flight]) {
        dateOut = flightdate
        flights = flightInfo.map {
            FlightCardViewModel(
                departure: departureAiport,
                destination: destinationAirport,
                flightNumber: $0.flightNumber,
                departureTime: $0.time.first!,
                arrivalTime: $0.time.last!,
                duration: $0.duration
            )
        }
    }
    
    mutating func toggleSelectState() {
        isSelected.toggle()
    }
}

struct FlightCardViewModel {
    var departure: String
    var destination: String
    var flightNumber: String
    var departureTime: String
    var arrivalTime: String
    var duration: String
}
