//
//  PlanetsResponse.swift
//  Yulia_Korniichuk_JPMC
//
//  Created by Yulia Kornichuk on 20/05/2023.
//

import Foundation
import CoreData

struct PlanetsResponse: Codable {
  let count: Int
  let next: String?
  let previous: String?
  let results: [Planet]
}

struct Planet: Codable {
  let name: String
  let rotationPeriod: String
  let orbitalPeriod: String
  let diameter: String
  let climate: String
  let gravity: String
  let terrain: String
  let surfaceWater: String
  let population: String
  let residents: [String]
  let films: [String]
  let created: String
  let edited: String
  let url: String
  
  enum CodingKeys: String, CodingKey {
    case rotationPeriod = "rotation_period"
    case orbitalPeriod = "orbital_period"
    case surfaceWater = "surface_water"
    
    case name, diameter, climate, gravity, terrain,
         population, residents, films, created, edited, url
  }
}

extension Planet {
  
  // used for mapping from CoreData entity
  init(from entity: PlanetEntity) {
    self.init(
      name: entity.name ?? "",
      rotationPeriod: "",
      orbitalPeriod: "",
      diameter: "",
      climate: "",
      gravity: "",
      terrain: entity.terrain ?? "",
      surfaceWater: "",
      population: entity.population ?? "",
      residents: [],
      films: [],
      created: "",
      edited: "",
      url: "")
  }
}
