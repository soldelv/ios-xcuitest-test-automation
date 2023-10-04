//
//  CalendarView.swift
//  RyanairAutomation
//

import SwiftUI

struct CalendarView: View {
   @Binding var date: Date
   @Binding var isPresented: Bool
   
   var body: some View {
      VStack {
         Spacer()
         DatePicker(
            "Start Date",
            selection: $date,
            in: Date()...,
            displayedComponents: [.date]
         )
         .datePickerStyle(.graphical)
         Spacer()
         ContinueButton(
            text: "Select date",
            action: { isPresented.toggle() }
         )
      }
      .padding()
   }
}

struct CalendarView_Previews: PreviewProvider {
   static var previews: some View {
      NavigationView {
         CalendarView(date: .constant(Date()), isPresented: .constant(true))
      }
      .rynNavigation()
   }
}
