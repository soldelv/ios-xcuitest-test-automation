//
//  FindFlightsView.swift
//  RyanairAutomation
//

import SwiftUI

struct FindFlightsView: View {
   @StateObject var flightViewModel = FindFlightsViewModel()
   @EnvironmentObject var navController: NavigationController
   @EnvironmentObject var model: Model
   @State var showAlert = false
   
   var body: some View {
      VStack(alignment: .leading, spacing: 10) {
         TripTypeButton()
         AirportButtons()
         FlightDateButtons()
         AddPassengersButton()
         Spacer()
         ContinueButton(text: "Let's go") {
             model.updateAvailabilityRequest(params: flightViewModel.createAvailabilityRequest())
            navController.showFlightSelectView.toggle()
         }
         NavigationLink("Hidden navigation", isActive: $navController.showFlightSelectView) {
            FlightSelectView()
         }
         .hidden()
      }
      .padding()
      .navigationTitle("FindFlights")
      .navigationBarBackButtonHidden(true)
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
         ToolbarItem(placement: .navigationBarLeading) {
            Button(action: {
               navController.showFindFlightsView.toggle()
            }, label: {
               Image(systemName: "chevron.backward")
                  .foregroundColor(.white)
            })
         }
      }
      .environmentObject(flightViewModel)
      .background(Color.rynBackground)
   }
}

struct FindFlights_Previews: PreviewProvider {
   static var previews: some View {
      NavigationView {
         FindFlightsView(flightViewModel: FindFlightsViewModel())
            .environmentObject(NavigationController())
            .rynNavigation()
      }
   }
}
