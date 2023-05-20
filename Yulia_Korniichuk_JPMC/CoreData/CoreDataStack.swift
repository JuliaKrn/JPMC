//
//  CoreDataStack.swift
//  Yulia_Korniichuk_JPMC
//
//  Created by Yulia Kornichuk on 20/05/2023.
//

import Foundation
import CoreData

protocol CoreDataStackProtocol {
  var managedObjectContext: NSManagedObjectContext { get }
}

class CoreDataStack: CoreDataStackProtocol {
  
  static let shared = CoreDataStack()
  
  private init() {}

  var managedObjectContext: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Yulia_Korniichuk_JPMC")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
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

