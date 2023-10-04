//
//  AvailabilityService.swift
//  RyanairAutomation
//

import Foundation

class NetworkManager {
    
    enum NetworkError: Error {
        case failed,
             failedToDecode,
             invalidStatusCode
    }
    
   static func fetch<T: Codable>(_ path: String,_ httpMethod: String = "GET") async throws -> T {
        let url = URL(string: path)!
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.setValue(HttpHeaders.jsonContenType.rawValue, forHTTPHeaderField: HttpHeaders.contenTypeHeader.rawValue)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            print("Network error: \(response.debugDescription)")
            throw NetworkError.invalidStatusCode
        }
      
        var decodedData: T
        do {
            decodedData = try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Failed to decode: \(error)")
            throw NetworkError.failedToDecode
        }
        return decodedData
    }
}

enum HttpHeaders: String {
   case contenTypeHeader = "Content-Type"
   case jsonContenType = "application/json; charset=UTF-8"
}
