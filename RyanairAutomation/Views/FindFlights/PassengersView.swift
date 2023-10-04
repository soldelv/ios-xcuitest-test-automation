//
//  PassengersView.swift
//  RyanairAutomation
//

import SwiftUI

struct PassengersView: View {
   @EnvironmentObject var viewModel: FindFlightsViewModel
   @Environment(\.presentationMode) var presentationMode
   @State private var adultCount = 1
   @State private var teensCount = 0
   @State private var childrenCount = 0
   @State private var infantsCount = 0
   
   var body: some View {
      ZStack {
         VStack {
            PassengerCell(text: "Adults", subText: "16 years and more", value: $adultCount)
            PassengerCell(text: "Teens", subText: "12-15 years", value: $teensCount)
            PassengerCell(text: "Children", subText: "2-11 years", value: $childrenCount)
            PassengerCell(text: "Infants", subText: "Under 2 years", value: $infantsCount)
            Spacer()
            ContinueButton(text: "Confirm", action: {
               viewModel.setPassengerList(adultCount, teensCount, childrenCount, infantsCount)
               presentationMode.wrappedValue.dismiss()
            })
         }
         .padding()
      }
      .background(Color.rynBackground)
   }
}

struct PassengersView_Previews: PreviewProvider {
   static var previews: some View {
      NavigationView {
         PassengersView()
            .environmentObject(FindFlightsViewModel())
      }
   }
}

struct PassengerCell: View {
   var text: String
   var subText: String
   @Binding var value: Int
   
   var body: some View {
      HStack {
         VStack(alignment: .leading) {
            Text(text)
               .foregroundColor(.black)
               .font(.title2)
            Text(subText)
               .foregroundColor(.gray)
         }
         Spacer()
         HStack {
            Button(action: {
               if value != 0 {
                  value -= 1
               }
            }) {
               Image(systemName: "minus.circle")
            }
            Text(String(value))
               .accessibilityIdentifier("passenger_\(text.lowercased())_count")
            Button(action: {
               value += 1
            }) {
               Image(systemName: "plus.circle")
            }
         }
         .font(.title2)
      }
      .padding()
   }
}
