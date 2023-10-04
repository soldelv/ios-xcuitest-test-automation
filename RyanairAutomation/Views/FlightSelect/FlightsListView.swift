//
//  FlightsListView.swift
//  RyanairAutomation
//

import SwiftUI

struct FlightsListView: View {
    @StateObject var viewModel = FlightSelectViewModel()
    @EnvironmentObject var navController: NavigationController
    @EnvironmentObject var model: Model
    @State var showAlert = false
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 8) {
                ForEach(viewModel.flightDateList, id: \.id) { flightDate in
                    FlightDateTabButton(flightDate: flightDate.dateOut,
                                        isSelected: flightDate.isSelected,
                                        action: { viewModel.selectNewDate(id: flightDate.id) },
                                        flightsAvailable: flightDate.flights.isEmpty ? false : true
                    )
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: 80)
            .background(Color.white)
            .padding([.horizontal])
            VStack {
                if viewModel.flightDateList.isEmpty {
                    ProgressView()
                } else {
                    let fligthList = viewModel.getFlightByDate()
                    if fligthList.count >= 1 {
                        ScrollView {
                            ForEach(fligthList, id: \.flightNumber) { flight in
                                FlightCard(departureAirport: flight.departure,
                                           destinationAirport: flight.destination,
                                           departureTime: flight.departureTime,
                                           arrivalTime: flight.arrivalTime,
                                           flightTime: flight.duration,
                                           flightNumber: flight.flightNumber,
                                           action: { showAlert = true }
                                )
                                .alert(Text("Trip booked"), isPresented: $showAlert) {
                                    Button("Ok") {
                                        navController.showFindFlightsView.toggle()
                                        navController.showFlightSelectView.toggle()
                                        showAlert = false
                                    }
                                    Button("Cancel") {
                                        showAlert = false
                                    }
                                } message: {
                                    Text("Congratulations! You selected flight: \(flight.flightNumber) from \(flight.departure) to \(flight.destination)")
                                }
                            }
                        }
                        .padding(.top)
                        .ignoresSafeArea()
                    } else {
                        NoFlightsView(text: "No flight for this day")
                    }
                }
                Spacer()
            }
            .background(Color.rynBackground)
        }
        .onAppear {
            viewModel.updateModel(with: model.trip)
        }
    }
}

struct FlightsListView_Previews: PreviewProvider {
    static let testData = FlightResponse(trips: [RyanairAutomation.Trip(origin: "WRO", originName: "Wroclaw", destination: "DUB", destinationName: "Dublin ", tripType: "OTHER", dates: [RyanairAutomation.FlightDates(dateOut: "2021-11-29T00:00:00.000", flights: []), RyanairAutomation.FlightDates(dateOut: "2021-12-01T00:00:00.000", flights: [RyanairAutomation.Flight(flightNumber: "FR 1927", time: ["2021-12-01T17:35:00.000", "2021-12-01T19:20:00.000"], duration: "02:45", operatedBy: "Buzz")]), RyanairAutomation.FlightDates(dateOut: "2021-12-02T00:00:00.000", flights: [RyanairAutomation.Flight(flightNumber: "FR 1927", time: ["2021-12-02T16:45:00.000", "2021-12-02T18:30:00.000"], duration: "02:45", operatedBy: "Buzz")])])])
    
    static var previews: some View {
        NavigationView {
            FlightsListView()
                .environmentObject(NavigationController())
                .navigationTitle("Flights")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
