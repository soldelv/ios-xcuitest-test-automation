//
//  FlightCard.swift
//  RyanairAutomation
//

import SwiftUI

struct FlightCard: View {
   var departureAirport: String
   var destinationAirport: String
   var departureTime: String
   var arrivalTime: String
   var flightTime: String
   var flightNumber: String
   var action: () -> Void
   
   var maxHeight = CGFloat(100)
   
   var body: some View {
      VStack {
         HStack {
            Color.white.frame(width: UIScreen.main.bounds.width - 16, height: UIScreen.main.bounds.height/8, alignment: .center)
               .cornerRadius(8)
               .shadow(color: .gray, radius: 1, x: 1, y: 1)
               .overlay {
                  HStack(spacing: 8) {
                     VStack {
                        Color.yellow
                           .frame(minWidth: 1, maxWidth: 5, maxHeight: maxHeight)
                     }
                     VStack(alignment: .leading) {
                        Text(departureTime.toString(inputFormat: .dateTimeUtc, outputFormat: .timeOnly))
                           .font(.title2)
                        Text(departureAirport)
                           .font(.subheadline)
                     }
                     Spacer()
                     VStack {
                        Text(flightTime)
                           .font(.subheadline)
                        Divider().padding(.horizontal)
                        Text(flightNumber)
                           .font(.subheadline)
                     }
                     .foregroundColor(.gray)
                     Spacer()
                     VStack(alignment: .trailing) {
                        Text(arrivalTime.toString(inputFormat: .dateTimeUtc, outputFormat: .timeOnly))
                           .font(.title2)
                        Text(destinationAirport)
                           .font(.subheadline)
                     }
                     .padding(.trailing)
                  }
               }
         }
      }
      .onTapGesture {
         action()
      }
   }
}

struct FlightCard_Previews: PreviewProvider {
   static var previews: some View {
      FlightCard(departureAirport: "WRO", destinationAirport: "DUB", departureTime: "2021-11-25T16:45:00.000", arrivalTime: "2021-11-25T18:45:00.000", flightTime: "2 godz. 50 min", flightNumber: "FR 7823", action: {})
   }
}
