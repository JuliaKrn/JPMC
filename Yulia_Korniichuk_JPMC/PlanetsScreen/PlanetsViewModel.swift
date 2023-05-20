//
//  PlanetsViewModel.swift
//  Yulia_Korniichuk_JPMC
//
//  Created by Yulia Kornichuk on 20/05/2023.
//

import Foundation

protocol PlanetsViewModelProtocol {
  var planets: [Planet] { get }
  var updatePlanets: (() -> Void)? { get set }
  var errorLoadingPlanets: (() -> Void)? { get set }
  
  func loadPlanets()
}

final class PlanetsViewModel: PlanetsViewModelProtocol {
  var planets: [Planet] = []
  var updatePlanets: (() -> Void)?
  var errorLoadingPlanets: (() -> Void)?
  
  private let planetsRepo: PlanetsRepositoryProtocol
  
  init(planetsRepo: PlanetsRepositoryProtocol) {
    self.planetsRepo = planetsRepo
  }
  
  func loadPlanets() {
    Task {
      let loadedPlanets = try await self.planetsRepo.loadPlanets()
      
      if let loadedPlanets, !loadedPlanets.isEmpty {
        planets = loadedPlanets
        updatePlanets?()
      } else {
        errorLoadingPlanets?()
      }
    }
  }
  
}
