//
//  ContinueButton.swift
//  RyanairAutomation
//

import SwiftUI

struct ContinueButton: View {
   var image: String?
   var text: String
   var action: () -> Void
   
   var body: some View {
      Button(action: {
         action()
      }) {
         ContinueButtonView(image: image, text: text)
      }
      .accessibilityIdentifier("continue_button")
   }
}

struct ContinueButton_Previews: PreviewProvider {
   static var previews: some View {
      ContinueButton(image: "magnifyingglass", text: "Book a flight", action: {})
         .previewLayout(.sizeThatFits)
      
      ContinueButton(text: "Book a flight", action: {})
         .previewLayout(.sizeThatFits)
   }
}
