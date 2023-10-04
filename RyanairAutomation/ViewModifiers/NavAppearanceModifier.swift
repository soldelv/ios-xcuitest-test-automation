//
//  NavAppearanceModifier.swift
//  RyanairAutomation
//

import SwiftUI

struct NavAppearnaceModifier: ViewModifier {
   init() {
      let navBarAppearance = UINavigationBarAppearance()
      navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 20, weight: .medium)]
      navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
      navBarAppearance.backgroundColor = UIColor(named: "RyanairNavBlue")
      navBarAppearance.shadowColor = UIColor.yellow   
      
      UINavigationBar.appearance().standardAppearance = navBarAppearance
      UINavigationBar.appearance().compactAppearance = navBarAppearance
      UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
   }

   func body(content: Content) -> some View {
      content
   }
}

extension View {
   func rynNavigation() -> some View {
      self.modifier(NavAppearnaceModifier())
   }
}

