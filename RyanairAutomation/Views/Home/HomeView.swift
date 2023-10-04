//
//  HomeView.swift
//  RyanairAutomation
//

import SwiftUI

struct HomeView: View {
   @EnvironmentObject var navController: NavigationController
   
   var body: some View {
      ZStack {
         VStack(spacing: 8) {
            Spacer()
            NavigationLink(
               isActive: $navController.showFindFlightsView,
               destination: { FindFlightsView() }) {
                  ContinueButtonView(image: "magnifyingglass",
                                     text: "Book a flight")
               }
            HStack() {
               HomeCardView(imageName: "bag.fill", text: "My Trips")
               Spacer()
               HomeCardView(imageName: "airplane", text: "Boarding Passes")
               Spacer()
               HomeCardView(imageName: "doc.append.fill", text: "Inflight Magazine")
            }
            Spacer()
         }
         .padding()
         .navigationTitle("RYANAIR")
         .navigationBarTitleDisplayMode(.inline)
         .background(Color.rynBackground)
      }
   }
}

struct HomeView_Previews: PreviewProvider {
   static var previews: some View {
      NavigationView {
         HomeView()
            .previewDevice("iPhone 13 Pro Max")
            .environmentObject(NavigationController())
            .rynNavigation()
      }
   }
}
