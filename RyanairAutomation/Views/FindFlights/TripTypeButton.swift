//
//  TripTypeView.swift
//  RyanairAutomation
//

import SwiftUI

struct TripTypeButton: View {
   @EnvironmentObject var viewModel: FindFlightsViewModel
   
    var body: some View {
      HStack {
         TripButton(selectedTripType: $viewModel.tripType, type: .oneway, text: "One way") {
            viewModel.changeFlightType(to: .oneway)
         }
         TripButton(selectedTripType: $viewModel.tripType, type: .round, text: "Return") {
            viewModel.changeFlightType(to: .round)
         }
      }
      .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 30, maxHeight: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
      .background(.white)
      .cornerRadius(40)
      .shadow(color: .gray, radius: 1, x: 1, y: 1)
   }
}

struct TripTypeButton_Previews: PreviewProvider {
    static var previews: some View {
       TripTypeButton()
          .environmentObject(FindFlightsViewModel())
    }
}

struct TripButton: View {
   @Binding var selectedTripType: TripType
   var type: TripType
   var text: String
   var action: () -> Void
   
   var body: some View {
      Button(action: action, label: {
         Text(text)
            .font(.headline)
            .foregroundColor(type == selectedTripType ? Color.white : Color.gray)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .background(type == selectedTripType ? Color.yellow : Color.white)
            .cornerRadius(40)
      })
   }
}
