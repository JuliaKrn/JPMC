//
//  PlanetsResponseTests.swift
//  Yulia_Korniichuk_JPMCTests
//
//  Created by Yulia Kornichuk on 21/05/2023.
//

import XCTest

final class PlanetsResponseTests: XCTestCase {

  func testParsePlanetsResponse() throws {
    // Given
    let jsonString = """
        {
            "count": 60,
            "next": "https://swapi.dev/api/planets/?page=2",
            "previous": null,
            "results": [
                {
                    "name": "Tatooine",
                    "rotation_period": "23",
                    "orbital_period": "304",
                    "diameter": "10465",
                    "climate": "arid",
                    "gravity": "1 standard",
                    "terrain": "desert",
                    "surface_water": "1",
                    "population": "200000",
                    "residents": [
                        "https://swapi.dev/api/people/1/",
                        "https://swapi.dev/api/people/2/",
                        "https://swapi.dev/api/people/4/",
                        "https://swapi.dev/api/people/6/",
                        "https://swapi.dev/api/people/7/",
                        "https://swapi.dev/api/people/8/",
                        "https://swapi.dev/api/people/9/",
                        "https://swapi.dev/api/people/11/",
                        "https://swapi.dev/api/people/43/",
                        "https://swapi.dev/api/people/62/"
                    ],
                    "films": [
                        "https://swapi.dev/api/films/1/",
                        "https://swapi.dev/api/films/3/",
                        "https://swapi.dev/api/films/4/",
                        "https://swapi.dev/api/films/5/",
                        "https://swapi.dev/api/films/6/"
                    ],
                    "created": "2014-12-09T13:50:49.641000Z",
                    "edited": "2014-12-20T20:58:18.411000Z",
                    "url": "https://swapi.dev/api/planets/1/"
                },
                {
                    "name": "Alderaan",
                    "rotation_period": "24",
                    "orbital_period": "364",
                    "diameter": "12500",
                    "climate": "temperate",
                    "gravity": "1 standard",
                    "terrain": "grasslands, mountains",
                    "surface_water": "40",
                    "population": "2000000000",
                    "residents": [
                        "https://swapi.dev/api/people/5/",
                        "https://swapi.dev/api/people/68/",
                        "https://swapi.dev/api/people/81/"
                    ],
                    "films": [
                        "https://swapi.dev/api/films/1/",
                        "https://swapi.dev/api/films/6/"
                    ],
                    "created": "2014-12-10T11:35:48.479000Z",
                    "edited": "2014-12-20T20:58:18.420000Z",
                    "url": "https://swapi.dev/api/planets/2/"
                }
            ]
        }
        """
    
    let jsonData = jsonString.data(using: .utf8)!
    let decoder = JSONDecoder()
    
    // When
    let planetsResponse = try decoder.decode(PlanetsResponse.self, from: jsonData)
    
    // Then
    XCTAssertEqual(planetsResponse.count, 60, "Incorrect count")
    XCTAssertEqual(planetsResponse.results.count, 2, "Incorrect count")
    XCTAssertEqual(planetsResponse.results[0].name, "Tatooine", "Incorrect name")
    XCTAssertEqual(planetsResponse.results[0].rotationPeriod, "23", "Incorrect rotationPeriod")
    XCTAssertEqual(planetsResponse.results[0].films.count, 5, "Incorrect number of films")
  }

}
