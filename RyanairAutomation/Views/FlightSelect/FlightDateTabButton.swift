//
//  FlightDateTab.swift
//  RyanairAutomation
//

import SwiftUI

struct FlightDateTabButton: View {
   var flightDate: String
   var isSelected: Bool
   var action: () -> Void
   var flightsAvailable: Bool
   let imageWidth: CGFloat = 35
   let imageHeight: CGFloat = 35
   
   var body: some View {
      Button {
         action()
      } label: {
         VStack {
            Text(flightDate.toString(inputFormat: .dateTimeUtc, outputFormat: .dayOfWeekDayMonth))
               .font(.subheadline)
               .foregroundColor(.rynBlue)
            if flightsAvailable {
               Image(systemName: "airplane.circle")
                  .resizable()
                  .frame(width: imageWidth, height: imageHeight, alignment: .center)
                  .foregroundColor(.black)
            } else {
               ZStack {
                  Image(systemName: "airplane.circle")
                     .resizable()
                  Image(systemName: "line.diagonal")
                     .resizable()
               }

               .frame(width: imageWidth, height: imageHeight, alignment: .center)
               .foregroundColor(.gray)
            }

            if isSelected {
               Color.yellow.frame(width: UIScreen.main.bounds.width/3, height: 4, alignment: .center).cornerRadius(8)
            } else {
               Color.white.frame(width: UIScreen.main.bounds.width/3, height: 4, alignment: .center).cornerRadius(8)
            }
         }
      }
   }
}

struct FligthDateTab_Previews: PreviewProvider {
   static var previews: some View {
      FlightDateTabButton(flightDate: "2021-11-25T16:45:00.000", isSelected: true, action: {}, flightsAvailable: true)
         .previewLayout(.sizeThatFits)
      
      FlightDateTabButton(flightDate: "2021-11-25T16:45:00.000", isSelected: false, action: {}, flightsAvailable: false)
         .previewLayout(.sizeThatFits)
   }
}
