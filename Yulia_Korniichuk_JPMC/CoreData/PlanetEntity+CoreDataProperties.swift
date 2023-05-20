//
//  PlanetEntity+CoreDataProperties.swift
//  Yulia_Korniichuk_JPMC
//
//  Created by Yulia Kornichuk on 20/05/2023.
//
//

import Foundation
import CoreData


extension PlanetEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlanetEntity> {
        return NSFetchRequest<PlanetEntity>(entityName: "PlanetEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var population: String?
    @NSManaged public var terrain: String?

}

extension PlanetEntity : Identifiable {

}
