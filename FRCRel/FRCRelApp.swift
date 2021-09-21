//
//  FRCRelApp.swift
//  FRCRel
//
//  Created by Michał Śmiałko on 21/09/2021.
//

import SwiftUI

@main
struct FRCRelApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
