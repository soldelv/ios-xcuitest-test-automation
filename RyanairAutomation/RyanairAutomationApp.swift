//
//  RyanairAutomationApp.swift
//  RyanairAutomation
//

import SwiftUI

@main
struct RyanairAutomationApp: App {
   @StateObject var model = Model()
   @StateObject var navController = NavigationController()
    var body: some Scene {
        WindowGroup {
           NavigationView {
              HomeView()
           }
           .rynNavigation()
           .environmentObject(model)
           .environmentObject(navController)
           .navigationViewStyle(.stack)
        }
    }
}
