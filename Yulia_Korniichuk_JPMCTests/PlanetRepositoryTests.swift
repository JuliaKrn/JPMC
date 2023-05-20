//
//  PlanetRepositoryTests.swift
//  Yulia_Korniichuk_JPMCTests
//
//  Created by Yulia Kornichuk on 20/05/2023.
//

import XCTest
import CoreData
@testable import Yulia_Korniichuk_JPMC

class PlanetsRepositoryTests: XCTestCase {
  
  var sut: PlanetsRepository!
  var mockNetworkService: NetworkServiceProtocol!
  var mockCoreDataStack: CoreDataStackProtocol!
  
  override func setUp() {
    super.setUp()
    mockNetworkService = MockNetworkService()
    mockCoreDataStack = MockCoreDataStack.shared
    sut = PlanetsRepository(networkService: mockNetworkService, coreDataStack: mockCoreDataStack)
  }
  
  override func tearDown() {
    mockNetworkService = nil
    sut = nil
    super.tearDown()
  }
  
  func testLoadPlanetsFromNetworkSuccess() async throws {
    let planets = try await sut.loadPlanets()
    
    XCTAssertEqual(planets?.count, 2)
    XCTAssertEqual(planets?[0].name, "Tatooine")
    XCTAssertEqual(planets?[0].terrain, "desert")
    XCTAssertEqual(planets?[0].population, "100")
    XCTAssertEqual(planets?[1].name, "Alderaan")
    XCTAssertEqual(planets?[1].terrain, "mountains")
    XCTAssertEqual(planets?[1].population, "200")
  }
}

class MockNetworkService: NetworkServiceProtocol {
  func fetchPlanets() async throws -> [Planet] {
    return mockedPlanetsList()
  }

  private func mockedPlanetsList() -> [Planet] {
    let planet1 = Planet(
      name: "Tatooine",
      rotationPeriod: "",
      orbitalPeriod: "",
      diameter: "",
      climate: "",
      gravity: "",
      terrain: "desert",
      surfaceWater: "",
      population: "100",
      residents: [""],
      films: [""],
      created: "",
      edited: "",
      url: "")
    let planet2 = Planet(
      name: "Alderaan",
      rotationPeriod: "",
      orbitalPeriod: "",
      diameter: "",
      climate: "",
      gravity: "",
      terrain: "mountains",
      surfaceWater: "",
      population: "200",
      residents: [""],
      films: [""],
      created: "",
      edited: "",
      url: "")
    
    return [planet1, planet2]
  }
}

extension Planet: Equatable {
  static func == (lhs: Planet, rhs: Planet) -> Bool {
    lhs.name == rhs.name
  }
}

class MockCoreDataStack: CoreDataStackProtocol {
  static let shared = MockCoreDataStack()
  
  private init() {}
  
  var managedObjectContext: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  lazy var persistentContainer: NSPersistentContainer = {
    let description = NSPersistentStoreDescription()
    description.type = NSInMemoryStoreType
    let container = NSPersistentContainer(name: "Yulia_Korniichuk_JPMC_Test")
    container.persistentStoreDescriptions = [description]
    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    return container
  }()
  
  func saveContext () {
    if managedObjectContext.hasChanges {
      do {
        try managedObjectContext.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
}
