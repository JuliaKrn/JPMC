//
//  NetworkService.swift
//  Yulia_Korniichuk_JPMC
//
//  Created by Yulia Kornichuk on 20/05/2023.
//

import Foundation
protocol NetworkServiceProtocol {
  func fetchPlanets() async throws -> [Planet]
}

final class NetworkService: NetworkServiceProtocol {
  enum NetworkError: Error {
    case badUrl
  }
  
  private let baseURL = "https://swapi.dev/api/"
  private let planetsResource = "planets/"

  func fetchPlanets() async throws -> [Planet] {
    guard let url = URL(string: baseURL+planetsResource) else {
      throw NetworkError.badUrl
    }
    
    let session = URLSession.shared
    let (planetsData, _) = try await session.data(from: url)
    let planetsInfo = try JSONDecoder().decode(PlanetsResponse.self, from: planetsData)
    
    return planetsInfo.results
  }
  
}
