//
//  Model.swift
//  RyanairAutomation
//

import Foundation

@MainActor
class DataModel: ObservableObject {
   
   @Published var availabilityState: AvailabilityState = .na
   var availabilityRequestParams: AvailabilityRequest?
   
}

enum AvailabilityState {
   case na,
        loading,
        success(data: AvailabilityResponse),
        failed(error: Error)
}

extension DataModel {
   
   func updateAvailabilityRequest(params: AvailabilityRequest) {
      availabilityRequestParams = params
   }

   func getAvailability() async {
      if let params = self.availabilityRequestParams {
         availabilityState = .loading
         print("Starting availablity request")
         do {
            let trips = try await AvailabilityService().fetchAvailability(params)
            availabilityState = .success(data: trips)
            print(trips)
         } catch {
            availabilityState = .failed(error: error)
            print(error)
         }
      } else {
         availabilityState = .na
      }
   }
}
