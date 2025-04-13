//
//  PersistenceController.swift
//  CryptoPriceTrackerDemo
//
//  Created by mac on 4/14/25.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)

        // You can insert mock favorites here if needed
        let viewContext = controller.container.viewContext
        let coin = FavoriteCoin(context: viewContext)
        coin.id = "eos"
        coin.name = "EOS"
        coin.symbol = "EOS"
        coin.imageUrl = "https://...replace_with_url..."

        do {
            try viewContext.save()
        } catch {
            fatalError("Preview save error: \(error)")
        }

        return controller
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CryptoModel") // actual model name
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved Core Data error: \(error), \(error.userInfo)")
            }
        }
    }
}
