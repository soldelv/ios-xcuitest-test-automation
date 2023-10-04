//
//  FlightSelectView.swift
//  RyanairAutomation
//

import SwiftUI

struct FlightSelectView: View {
    @EnvironmentObject var model: Model
    @EnvironmentObject var navController: NavigationController
    
    var body: some View {
        VStack {
            switch self.model.availabilityState {
            case .na:
                VStack {
                    Text("Connection problems...")
                        .font(.title)
                    ContinueButton(text: "Retry") {
                        fetchFligts()
                    }
                }
                .padding()
            case .loading:
                ProgressView()
            case .success:
                FlightsListView()
            case .failed:
                VStack {
                    NoFlightsView(text: "No flights for this route.")
                    ContinueButton(text: "Search new flight", action: { navController.showFlightSelectView.toggle()
                    })
                }
                .padding()
            }
        }
        .onAppear {
            fetchFligts()
        }
        .navigationTitle("Flights")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(action: {
                    navController.showFlightSelectView.toggle()
                }, label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.white)
                })
            }
        }
    }
    
    func fetchFligts() {
        Task {
            await model.getAvailability()
        }
    }
}

struct FlightSelect_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FlightSelectView()
                .environmentObject(Model())
                .environmentObject(NavigationController())
                .rynNavigation()
        }
    }
}
