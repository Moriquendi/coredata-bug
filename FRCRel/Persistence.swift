//
//  Persistence.swift
//  FRCRel
//
//  Created by Michał Śmiałko on 21/09/2021.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "FRCRel")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        
        print("DB URL: \(container.persistentStoreCoordinator.persistentStores.first?.url)")
        
        let composition: Composition = container.viewContext.newOrExistingObject(id: "composition")
        let track: Track = container.viewContext.newOrExistingObject(id: "track")
        let clip: Clip = container.viewContext.newOrExistingObject(id: "clip")
        
        clip.track = track
        track.composition = composition
        try! container.viewContext.save()
        
        container.viewContext.undoManager = UndoManager()
    }
}
