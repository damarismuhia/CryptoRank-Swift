//
//  CoreDataStackProtocol.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 28/02/2025.
//

import CoreData
protocol CoreDataStackProtocol: AnyObject {
    var managedContext: NSManagedObjectContext { get }
    func loadPersistentContainer(completion: (() -> Void)?)
    func saveContextChanges(completionHandler: @escaping (Bool) -> Void)
}
