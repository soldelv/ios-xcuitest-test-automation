//
//  AirportsListView.swift
//  RyanairAutomation
//

import SwiftUI

struct AirportsListView: View {
   @EnvironmentObject var viewModel: FindFlightsViewModel
   @Binding var direction: Direction
   @Binding var isPresented: Bool
   @State private var searchText = ""
   
   var airports: [AirportViewModel] {
      if searchText.isEmpty {
         return viewModel.airportsList
      } else {
         return viewModel.airportsList.filter({ $0.airport.name.contains(searchText) || $0.airport.code.contains(searchText)})
      }
   }
   
   var body: some View {
      switch viewModel.aiportListLoaded {
         case .loading:
            ProgressView()
               .task {
                  await viewModel.getAirports()
               }
         case .done:
            airpotListView()
      }
   }
   
   fileprivate func airpotListView() -> some View {
      List {
         ForEach(airports) { airportModel in
            Button(action: {
               if direction == .departure {
                  viewModel.setDepartureAiport(airportModel)
               } else {
                  viewModel.setDestinationAirport(airportModel)
               }
               isPresented.toggle()
            }) {
               HStack {
                  VStack(alignment: .leading) {
                     Text(airportModel.airport.name)
                        .accessibilityIdentifier("airport_city_name_text")
                  }
                  Spacer()
                  Text(airportModel.airport.code)
                     .foregroundColor(.blue)
                     .accessibilityIdentifier("airport_country_code_text")
               }
            }
         }
      }
      .padding()
      .listStyle(.plain)
      .searchable(text: $searchText,
                  placement: .navigationBarDrawer(displayMode: .always),
                  prompt: "Search Airport")
   }
}

struct AirportsListView_Previews: PreviewProvider {
   static var previews: some View {
      NavigationView {
         AirportsListView(direction: .constant(.destination), isPresented: .constant(true))
            .environmentObject(FindFlightsViewModel())
      }
   }
}
