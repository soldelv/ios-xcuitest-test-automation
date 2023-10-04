//
//  FlightDateBtn.swift
//  RyanairAutomation
//

import SwiftUI

struct FlightDateButtons: View {
   @EnvironmentObject var viewModel: FindFlightsViewModel
   @State private var showCalendar = false
   @State private var showReturnCalendar = false
   @State private var flightDate = Date()
   @State private var returnFlightDate = Date()
   
   var body: some View {
      if viewModel.tripType == .oneway {
         HStack {
            FlightDateButton(text: "Fly Out",
                             subtext: $viewModel.flightDate,
                             showCalendar: $showCalendar,
                             date: $flightDate) {
               viewModel.setFlightDate(roundTrip: false, date: flightDate)
               showCalendar = false
            }
         }
         .cornerRadius(8)
         .shadow(color: .gray, radius: 1, x: 1, y: 1)
      } else {
         HStack {
            FlightDateButton(text: "Fly Out",
                             subtext: $viewModel.flightDate,
                             showCalendar: $showCalendar,
                             date: $flightDate) {
               viewModel.setFlightDate(roundTrip: false, date: flightDate)
               showCalendar = false
            }
            VStack(spacing: 4) {
               Image(systemName: "line.diagonal")
                  .rotationEffect(.degrees(-45))
               Image(systemName: "calendar")
               Image(systemName: "line.diagonal")
                  .rotationEffect(.degrees(-45))
            }
            .foregroundColor(.gray)
            Spacer()
            FlightDateButton(text: "Fly Back",
                             subtext: $viewModel.returnFlightDate,
                             showCalendar: $showReturnCalendar,
                             date: $returnFlightDate) {
               viewModel.setFlightDate(roundTrip: true, date: returnFlightDate)
            }
         }
         .frame(maxWidth: .infinity)
         .padding([.vertical])
         .background(.white)
         .cornerRadius(8)
         .shadow(color: .gray, radius: 1, x: 1, y: 1)
      }
   }
}

struct FlightDateButton: View {
   var text: String
   @Binding var subtext: String?
   @Binding var showCalendar: Bool
   @Binding var date: Date
   var onDismiss: () -> Void
   
   var body: some View {
      Button {
         showCalendar = true
      } label: {
         HStack {
            FlightDateDirection(text: text, subtext: subtext)
            Spacer()
         }
         .frame(maxWidth: .infinity)
         .padding()
         .background(.white)
      }
      .sheet(isPresented: $showCalendar,
             onDismiss: onDismiss,
             content: {
         NavigationView {
            CalendarView(date: $date, isPresented: $showCalendar)
               .navigationTitle("Select date")
               .navigationBarTitleDisplayMode(.inline)
               .toolbar {
                  ToolbarItem(placement: .cancellationAction) {
                     Button(action: {
                        showCalendar.toggle()
                     }) {
                        Image(systemName: "multiply")
                           .foregroundColor(.white)
                     }
                  }
               }
         }
      })
   }
}

struct FlightDateDirection: View {
   var text: String
   var subtext: String?
   var body: some View {
      VStack(alignment: .leading) {
         Text(text)
            .padding([.bottom], 4)
            .foregroundColor(.black)
         Text(subtext ?? "Select Date")
            .foregroundColor(subtext != nil ? .rynBlue : .gray)
      }
   }
}

struct FlightDateBtn_Previews: PreviewProvider {
   static var previews: some View {
      NavigationView {
         FlightDateButtons()
            .environmentObject(FindFlightsViewModel())
      }
      .rynNavigation()
   }
}
