//
//  CoreDataStack.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 28/02/2025.
//

import CoreData

class CoreDataStack: CoreDataStackProtocol {
    static let shared = CoreDataStack(modelName: "CryptoRank")
    private let persistentContainer: NSPersistentContainer
    var managedContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    init(modelName: String, inMemory: Bool = false) {
        let container = NSPersistentContainer(name: modelName)
        if inMemory { // for uni testing ....
            let description = NSPersistentStoreDescription()
           // description.type = NSInMemoryStoreType
            description.url = URL(fileURLWithPath: "/dev/null")
            container.persistentStoreDescriptions = [description]
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        self.persistentContainer = container
    }
    
    func loadPersistentContainer(completion: (() -> Void)?) {
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                logError("Failed to load store: \(error.localizedDescription)")
            }
            completion?()
        }
    }
    
    func saveContextChanges(completionHandler: @escaping (Bool) -> Void) {
        guard managedContext.hasChanges else { return}
        do {
            managedContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            try managedContext.save()
            completionHandler(true)
        } catch {
            debugPrint("CoreData save error: \(error.localizedDescription)")
            completionHandler(false)
        }
    }
}

