//
//  PlanetsRepository.swift
//  Yulia_Korniichuk_JPMC
//
//  Created by Yulia Kornichuk on 20/05/2023.
//

import Foundation
import CoreData

protocol PlanetsRepositoryProtocol {
  func loadPlanets() async throws -> [Planet]?
}

class PlanetsRepository: PlanetsRepositoryProtocol {

  var networkService: NetworkServiceProtocol
  var coreDataStack: CoreDataStackProtocol
  
  init(networkService: NetworkServiceProtocol, coreDataStack: CoreDataStackProtocol) {
    self.networkService = networkService
    self.coreDataStack = coreDataStack
  }
  
  
  func loadPlanets() async throws -> [Planet]? {
    do {
      // In  case of success, save the result to CoreData
      // and return fethed list to the caller
      let planets = try await networkService.fetchPlanets()
      saveToCoreData(planets: planets)
      
      return planets
    }
    catch {
      // In case of failure, try to load planets list from CoreData
      guard let localPlanets = loadLocalPlanets(),
            !localPlanets.isEmpty else {
        return nil
      }
      // map CoreData entities to Planet model
      // and return mapped list to the caller
      let planets = localPlanets.map { Planet(from: $0) }
    
      return planets
    }
  }
  
  private func saveToCoreData(planets: [Planet]) {
    let context = coreDataStack.managedObjectContext
    
    for planet in planets {
      do {
        // Check for duplicates using planet name as the unique identifier
        // and add a new entity if there is none
        let fetchRequest: NSFetchRequest<PlanetEntity> = PlanetEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", planet.name)
        let existingPlanets = try context.fetch(fetchRequest)
        
        if existingPlanets.isEmpty {
          let planetEntity = PlanetEntity(context: context)
          planetEntity.name = planet.name
          planetEntity.terrain = planet.terrain
          planetEntity.population = planet.population
          
          context.insert(planetEntity)
        }
      } catch {
        print("Error fetching planets from CoreData: \(error)")
      }
    }
    
    do {
      try context.save()
    } catch {
      print("Error saving planets to CoreData: \(error)")
    }
  }
  
  private func loadLocalPlanets() -> [PlanetEntity]? {
    let fetchRequest: NSFetchRequest<PlanetEntity> = PlanetEntity.fetchRequest()
    
    do {
      let fetchedPlanets = try coreDataStack.managedObjectContext.fetch(fetchRequest)
      return fetchedPlanets
    } catch {
      print("Error loading planets from CoreData: \(error)")
      return nil
    }
  }
}

