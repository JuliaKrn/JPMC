//
//  PlanetViewModelTests.swift
//  Yulia_Korniichuk_JPMCTests
//
//  Created by Yulia Kornichuk on 20/05/2023.
//

import XCTest
@testable import Yulia_Korniichuk_JPMC

final class PlanetViewModelTests: XCTestCase {
  
  var sut: PlanetsViewModel!
  var planetRepo: MockPlanetsRepo!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    planetRepo = MockPlanetsRepo()
    sut = PlanetsViewModel(planetsRepo: planetRepo)
  }
  
  override func tearDownWithError() throws {
    sut = nil
    planetRepo = nil
    
    try super.tearDownWithError()
  }
  
  func testLoadPlanetsSuccess() {
    // Given
    let expectation = self.expectation(description: "Planets loaded successfully")
    var updateCalled = false
    sut.updatePlanets = {
      updateCalled = true
      expectation.fulfill()
    }
    
    // When
    sut.loadPlanets()
    
    // Then
    waitForExpectations(timeout: 1.0) { [weak self] error in
      XCTAssertNil(error, "Error: \(error?.localizedDescription ?? "")")
      XCTAssertTrue(updateCalled, "Update closure should have been called")
      XCTAssertEqual(self?.sut.planets.count, 2, "Unexpected number of planets")
      XCTAssertEqual(self?.sut.planets[0].name, "Tatooine", "Unexpected planet name")
      XCTAssertEqual(self?.sut.planets[1].name, "Alderaan", "Unexpected planet name")
    }
  }
  
  func testLoadPlanetsFail() {
    // Given
    let expectation = self.expectation(description: "Error loading planets")
    var errorCalled = false
    sut.errorLoadingPlanets = {
      errorCalled = true
      expectation.fulfill()
    }
    planetRepo.shouldReturnNil = true
    
    // When
    sut.loadPlanets()
    
    // Then
    waitForExpectations(timeout: 1.0) { [weak self] error in
      XCTAssertNil(error, "Error: \(error?.localizedDescription ?? "")")
      XCTAssertTrue(errorCalled, "Error closure should have been called")
      XCTAssertEqual(self?.sut.planets.count, 0, "Planets array should be empty")
    }
  }

}

class MockPlanetsRepo: PlanetsRepositoryProtocol {
  var shouldReturnNil: Bool = false
  
  func loadPlanets() async throws -> [Planet]? {
    if shouldReturnNil {
      return nil
    }
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
