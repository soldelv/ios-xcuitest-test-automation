//
//  HomeCardView.swift
//  RyanairAutomation
//

import SwiftUI

struct HomeCardView: View {
   var imageName: String
   var text: String
   
   var body: some View {
      VStack {
         Image(systemName: imageName)
            .padding([.horizontal], 8)
            .foregroundColor(.rynBlue)
         Text(text)
            .foregroundColor(.black)
            .lineLimit(2)
            .padding([.horizontal])
      }
      .multilineTextAlignment(.center)
      .frame(maxWidth: .infinity, maxHeight: 100)
      .background(Color.white)
      .cornerRadius(8)
      .shadow(color: .gray, radius: 1, x: 1, y: 2)
   }
}

struct HomeCardView_Previews: PreviewProvider {
    static var previews: some View {
       Group {
          HomeCardView(imageName: "folder.fill", text: "My Trip")
          HomeCardView(imageName: "airplane", text: "Boarding Passes")
          HomeCardView(imageName: "doc.append.fill", text: "Inflight Magazine")
       }
       .previewLayout(.fixed(width: 300, height: 100))
    }
}
