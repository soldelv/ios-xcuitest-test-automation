//
//  ContinueButtonView.swift
//  RyanairAutomation
//


import SwiftUI

struct ContinueButtonView: View {
   var image: String?
   var text: String

   var body: some View {
      HStack {
         if let imageName = image {
            Image(systemName: imageName)
         }
         Text(text)
            .padding([.bottom, .top])
            .accessibilityIdentifier("continue_text")
      }
      .frame(maxWidth: .infinity)
      .foregroundColor(.rynBlue)
      .font(.headline)
      .background(.yellow)
      .cornerRadius(4.0)
   }
}

struct ContinueButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ContinueButtonView(image: "magnifyingglass", text: "Book a flight")
          .previewLayout(.sizeThatFits)
    }
}
