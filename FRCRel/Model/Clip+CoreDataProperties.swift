//
//  Clip+CoreDataProperties.swift
//  Clip
//
//  Created by Michał Śmiałko on 21/09/2021.
//
//

import Foundation
import CoreData


extension Clip {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Clip> {
        return NSFetchRequest<Clip>(entityName: "Clip")
    }

    @NSManaged public var timestamp: Date?
    @NSManaged public var id: String?
    @NSManaged public var track: Track?

}

extension Clip : Identifiable {

}
