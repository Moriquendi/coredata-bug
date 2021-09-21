//
//  ContentView.swift
//  FRCRel
//
//  Created by Michał Śmiałko on 21/09/2021.
//

import SwiftUI
import CoreData
import Combine
import AVFoundation

class ViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
    
    @Published var logs: [String] = []
    
    private var count = 0
    private var sinks: Set<AnyCancellable> = []
    private var frc: NSFetchedResultsController<Clip>
    
    override init() {
        let request: NSFetchRequest<Clip> = Clip.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        frc = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: PersistenceController.shared.container.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil)

        super.init()

        frc.delegate = self
        try! frc.performFetch()
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("⭐️ FRC: Did Change content.")
        self.logs.append("[\(self.count)] Change detected!")
        self.count += 1
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        print("FRC: Did update object.")
    }
    
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Clip.timestamp, ascending: true)],
        animation: .default)
    private var clips: FetchedResults<Clip>
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        HStack {
            ScrollView(.vertical) {
                Text(viewModel.logs.joined(separator: "\n"))
                    .multilineTextAlignment(.leading)
            }
            .frame(width: 300)
            .frame(maxHeight: .infinity)
            .border(Color.red)
            
            VStack(alignment: .leading, spacing: 15) {
                GroupBox {
                    Text("Clicking the button below updates the NSManagedObject. Every time you click the button, the change should be noticed by NSFetchedResultsController. If it does - you'll see a log on the left. In my tests, the change is noticed only for the first time. Subsequent clicks do nothing. FetchedResultsController notice changes only after manually calling `processPendingChanges` (the button below)")
                    Button(action: editTime) {
                        Text("Edit Object")
                    }
                }
                
                GroupBox {
                    Text("This will manually call `processPendingChanges()`")
                    Button(action: {
                        viewContext.processPendingChanges()
                    }) {
                        Text("Force: PROCESS PENDING CHANGES")
                    }
                }
                
                Text("""
My findings:
- removing undoManager from NSManagedObjectContext fixes the issue
- wrapping the change of `clips[0].timestamp` in begin/end UndoGrouping fixes the issue
""")
                    .multilineTextAlignment(.leading)
            }
            
        }
        .padding(.top, 50)
        .frame(width: 700, height: 500)
        .onChange(of: clips.first?.timestamp) { time in
            print("[ℹ️] onChange()")
            guard let track = clips.first?.track else { return }
            track.someValue = Double(arc4random())
        }
    }
    
    private func editTime() {
        print("[ℹ️] Edit timestamp")
        clips[0].timestamp = Date()
    }
    
}
