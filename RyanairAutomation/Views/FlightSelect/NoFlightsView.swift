//
//  NoFlightsView.swift
//  RyanairAutomation
//

import SwiftUI

struct NoFlightsView: View {
   var text: String
   var body: some View {
      VStack {
         Spacer()
         ZStack {
            Image(systemName: "airplane.circle")
               .resizable()
               .frame(width: UIScreen.main.bounds.width/4,
                      height: UIScreen.main.bounds.height/6,
                      alignment: .center)
            Image(systemName: "line.diagonal")
               .resizable()
               .frame(width: UIScreen.main.bounds.width/4
                      , height: UIScreen.main.bounds.height/6,
                      alignment: .center)
         }
         .foregroundColor(Color.gray)
         Text(text)
            .foregroundColor(Color.gray)
         Spacer()
      }
      .frame(
         maxWidth: .infinity, maxHeight: .infinity
      )
   }
}

struct NoFlightsView_Previews: PreviewProvider {
   static var previews: some View {
      NoFlightsView(text: "No flight for today")
   }
}
