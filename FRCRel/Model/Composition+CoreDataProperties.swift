//
//  Composition+CoreDataProperties.swift
//  Composition
//
//  Created by Michał Śmiałko on 21/09/2021.
//
//

import Foundation
import CoreData


extension Composition {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Composition> {
        return NSFetchRequest<Composition>(entityName: "Composition")
    }

    @NSManaged public var id: String?
    @NSManaged public var tracks: NSOrderedSet?

}

// MARK: Generated accessors for tracks
extension Composition {

    @objc(insertObject:inTracksAtIndex:)
    @NSManaged public func insertIntoTracks(_ value: Track, at idx: Int)

    @objc(removeObjectFromTracksAtIndex:)
    @NSManaged public func removeFromTracks(at idx: Int)

    @objc(insertTracks:atIndexes:)
    @NSManaged public func insertIntoTracks(_ values: [Track], at indexes: NSIndexSet)

    @objc(removeTracksAtIndexes:)
    @NSManaged public func removeFromTracks(at indexes: NSIndexSet)

    @objc(replaceObjectInTracksAtIndex:withObject:)
    @NSManaged public func replaceTracks(at idx: Int, with value: Track)

    @objc(replaceTracksAtIndexes:withTracks:)
    @NSManaged public func replaceTracks(at indexes: NSIndexSet, with values: [Track])

    @objc(addTracksObject:)
    @NSManaged public func addToTracks(_ value: Track)

    @objc(removeTracksObject:)
    @NSManaged public func removeFromTracks(_ value: Track)

    @objc(addTracks:)
    @NSManaged public func addToTracks(_ values: NSOrderedSet)

    @objc(removeTracks:)
    @NSManaged public func removeFromTracks(_ values: NSOrderedSet)

}

extension Composition : Identifiable {

}
