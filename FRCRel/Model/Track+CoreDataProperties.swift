//
//  Track+CoreDataProperties.swift
//  Track
//
//  Created by Michał Śmiałko on 21/09/2021.
//
//

import Foundation
import CoreData


extension Track {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Track> {
        return NSFetchRequest<Track>(entityName: "Track")
    }

    @NSManaged public var id: String?
    @NSManaged public var someValue: Double
    @NSManaged public var composition: Composition?
    @NSManaged public var clips: NSSet?

}

// MARK: Generated accessors for clips
extension Track {

    @objc(addClipsObject:)
    @NSManaged public func addToClips(_ value: Clip)

    @objc(removeClipsObject:)
    @NSManaged public func removeFromClips(_ value: Clip)

    @objc(addClips:)
    @NSManaged public func addToClips(_ values: NSSet)

    @objc(removeClips:)
    @NSManaged public func removeFromClips(_ values: NSSet)

}

extension Track : Identifiable {

}
