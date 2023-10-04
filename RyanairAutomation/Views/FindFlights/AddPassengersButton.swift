//
//  AddPassengersButton.swift
//  RyanairAutomation
//

import SwiftUI

struct AddPassengersButton: View {
   @EnvironmentObject var viewModel: FindFlightsViewModel
   @State private var showPassengersView = false
   
   var body: some View {
      Button {
         showPassengersView.toggle()
      } label: {
         HStack {
            VStack(alignment: .leading) {
               Text("Passengers")
                  .padding([.bottom], 4)
                  .foregroundColor(.black)
               Text(getPassengersString(passengers: viewModel.passengers))
                  .foregroundColor(.rynBlue)
            }
            Spacer()
         }
         .padding()
      }
      .background(Color.white)
      .cornerRadius(8)
      .shadow(color: .gray, radius: 1, x: 1, y: 1)
      .accessibilityIdentifier("find_flights_add_passengers_button")
      .fullScreenCover(isPresented: $showPassengersView, onDismiss: {}) {
         NavigationView {
            PassengersView()
               .navigationTitle("Passengers")
               .navigationBarTitleDisplayMode(.inline)
               .toolbar {
                  ToolbarItem(placement: .cancellationAction) {
                     Button(action: {
                        showPassengersView.toggle()
                     }) {
                        Image(systemName: "multiply")
                           .foregroundColor(.white)
                     }
                  }
               }
         }
      }
   }
   
   func getPassengersString(passengers: Passengers) -> String {
      var passengersText = "1 Adult (16+ years)"
      if passengers.adults > 1 {
         passengersText = "\(passengers.adults) Adults"
      }
      if passengers.children != 0 || passengers.teens != 0 || passengers.infants != 0 {
         passengersText = "\(passengers.adults) Adult"
      }
      if passengers.teens == 1 {
         passengersText += ", 1 Teen"
      }
      if passengers.teens > 1 {
         passengersText += ", \(passengers.teens) Teens"
      }
      if passengers.children == 1 {
         passengersText += ", 1 Child"
      }
      if passengers.children > 1 {
         passengersText += ", \(passengers.children) Children"
      }
      if passengers.infants == 1 {
         passengersText += ", 1 Infant"
      }
      if passengers.infants > 1 {
         passengersText += ", \(passengers.infants) Infants"
      }
      return passengersText
   }
}

struct AddPassengersButton_Previews: PreviewProvider {
   static var previews: some View {
      AddPassengersButton()
         .previewDevice("iPhone 11")
         .environmentObject(FindFlightsViewModel())
      
      AddPassengersButton()
         .previewDevice("iPhone 8")
         .environmentObject(FindFlightsViewModel())
      
      AddPassengersButton()
         .previewDevice("iPhone 12 Pro")
         .environmentObject(FindFlightsViewModel())
   }
}
