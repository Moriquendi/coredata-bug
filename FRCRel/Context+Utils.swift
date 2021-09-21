//
//  NSManagedObjectContext+Utils.swift
//  Pompom
//
//  Created by Michał Śmiałko on 23/09/2020.
//

import Foundation
import CoreData

public extension NSManagedObjectContext {

    func newOrExistingObject<T: NSManagedObject>(id: String, objectIDURL: URL? = nil) -> T {
        if let objectIDURL = objectIDURL {
            if let existing = existingObject(URI: objectIDURL) {
                return existing as! T
            }
        } else if let existing: T = existingObject(id: id) {
            return existing
        }

        return newObject(id: id)
    }

    func existingObject<T: NSManagedObject>(id: String) -> T? {
        let className = NSStringFromClass(T.classForCoder())
        let request = NSFetchRequest<T>(entityName: className)
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        let results = try! self.fetch(request)

        if let result = results.first {
            return result
        }
        return nil
    }

    func newObject<T: NSManagedObject>(id: String? = UUID().uuidString) -> T {
        let className = NSStringFromClass(T.classForCoder())
        print("[ℹ️] New object: \(className)")
        let result = NSEntityDescription.insertNewObject(forEntityName: className, into: self)
        result.setValue(id, forKey: "id")

        // TODO: ?
        //result.setValue(Date(), forKey: "createdAt")

        return result as! T
    }

    // *************** //
    //   More generic  //
    // *************** //
    func newOrExistingObject<T: NSManagedObject>(primaryKey: String, value: Any) -> T {
        if let existing: T = existingObject(primaryKey: primaryKey, value: value) {
            return existing
        }

        return newObject(primaryKey: primaryKey, value: value)
    }

    func existingObject<T: NSManagedObject>(primaryKey: String, value: Any) -> T? {
        let className = NSStringFromClass(T.classForCoder())
        let request = NSFetchRequest<T>(entityName: className)

        request.predicate = NSPredicate(format: "\(primaryKey) == %@", argumentArray: [value])
        let results = try! self.fetch(request)

        if let result = results.first {
            return result
        }
        return nil
    }

    func newObject<T: NSManagedObject>(primaryKey: String, value: Any) -> T {
        let result: T = newObject()
        result.setValue(value, forKey: primaryKey)

        return result
    }

    // Fast
    
    func existingObject<T: NSManagedObject>(URI: URL) -> T? {
        guard let objectID = persistentStoreCoordinator?.managedObjectID(forURIRepresentation: URI) else {
            return nil
        }
        return try? existingObject(with: objectID) as? T
    }

}
