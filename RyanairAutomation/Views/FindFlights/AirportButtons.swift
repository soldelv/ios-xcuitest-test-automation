//
//  AirportButtons.swift
//  RyanairAutomation
//


import SwiftUI

enum Direction {
   case departure, destination
}

struct AirportButtons: View {
   @EnvironmentObject var viewModel: FindFlightsViewModel
   @State var departureSubtextColor: Color = .gray
   @State var destinationSubtextColor: Color = .gray
   @State private var showAirportList = false
   @State private var direction: Direction = .departure
   
   var body: some View {
      HStack {
         VStack(spacing: 4) {
            Image(systemName: "airplane")
               .rotationEffect(.degrees(+90))
            ForEach((1...3), id: \.self) { _ in
               Image(systemName: "line.diagonal")
                  .rotationEffect(.degrees(-45))
            }
            Image(systemName: "location.north.fill")
         }
         .foregroundColor(.gray)
         .padding([.leading], 8)
         VStack(alignment: .leading) {
            AiportButton(model: $viewModel.departure,
                         text: "From",
                         subText: "Where are you flying from?",
                         foregroundColor: $departureSubtextColor)
            {  direction = .departure
               showAirportList.toggle()
            }
            .accessibilityIdentifier("find_flighs_departure_button")
            Divider()
               .foregroundColor(/*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/)
               .padding([.trailing])
            AiportButton(model: $viewModel.destination,
                         text: "To",
                         subText: "Where are you going?",
                         foregroundColor: $destinationSubtextColor)
            { if viewModel.isDepartureAirportSelected() {
               direction = .destination
               showAirportList.toggle()
            } else {
               departureSubtextColor = .rynBlue
               }
            }
            .accessibilityIdentifier("find_flights_destination_button")
         }
         .fullScreenCover(isPresented: $showAirportList) {
            NavigationView {
               AirportsListView(direction: $direction, isPresented: $showAirportList)
                  .navigationTitle("Airports")
                  .toolbar {
                     ToolbarItem(placement: .cancellationAction) {
                        Button(action: {
                           showAirportList.toggle()
                        }) {
                           Image(systemName: "chevron.backward")
                              .foregroundColor(.white)
                        }
                     }
                  }
            }
         }
      }
      .padding([.top, .bottom])
      .background(Color.white)
      .cornerRadius(8)
      .shadow(color: .gray, radius: 1, x: 1, y: 1)
   }
}

struct AiportButton: View {
   @Binding var model: AirportViewModel?
   var text: String
   var subText: String
   @Binding var foregroundColor: Color
   var action: () -> Void
   
   var body: some View {
      Button(action: {
         action()
      }, label: {
         VStack(alignment: .leading) {
            HStack {
               Text(text)
                  .foregroundColor(.black)
               Spacer()
            }
            .padding([.bottom], 4)
            if let destination = model {
               HStack {
                  Text(destination.airport.name)
                  Spacer()
                  Text(destination.airport.code)
               }
               .padding([.horizontal])
               .foregroundColor(.rynBlue)
            } else {
               HStack {
                  Text(subText)
                     .foregroundColor(foregroundColor)
                  Spacer()
               }
               .padding([.horizontal])
            }
         }
      })
   }
}

struct AiportsView_Previews: PreviewProvider {
   static let wroclaw = AirportViewModel(airport: Airport(code: "WRO", name: "Wroclaw"))
   static let dublin = AirportViewModel(airport: Airport(code: "DUB", name: "Dublin"))
   
   static var departureModel: FindFlightsViewModel {
      let model = FindFlightsViewModel()
      model.setDepartureAiport(wroclaw)
      return model
   }
   
   static var destinationModel: FindFlightsViewModel {
      let model = FindFlightsViewModel()
      model.setDestinationAirport(dublin)
      return model
   }
   static var previews: some View {
      AirportButtons()
         .environmentObject(FindFlightsViewModel())
         .previewLayout(.sizeThatFits)
      AirportButtons()
         .environmentObject(departureModel)
         .previewLayout(.sizeThatFits)
      AirportButtons()
         .environmentObject(destinationModel)
         .previewLayout(.sizeThatFits)
   }
}
