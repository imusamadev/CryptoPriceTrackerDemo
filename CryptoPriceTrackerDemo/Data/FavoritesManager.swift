//
//  FavoritesManager.swift
//  CryptoPriceTrackerDemo
//
//  Created by mac on 4/14/25.
//

import CoreData
import SwiftUI

class FavoritesManager: ObservableObject {
    static let shared = FavoritesManager(context: PersistenceController.shared.container.viewContext)
    
    private let context: NSManagedObjectContext
    @Published var favoriteCoins: [FavoriteCoin] = []
    
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchFavorites()
    }
    
    func fetchFavorites() {
        let request: NSFetchRequest<FavoriteCoin> = FavoriteCoin.fetchRequest()
        do {
            favoriteCoins = try context.fetch(request)
        } catch {
            print("Fetch failed")
        }
    }
    
    func isFavorite(_ id: String) -> Bool {
        favoriteCoins.contains(where: { $0.id == id })
    }
    
    func toggleFavorite(coin: CoinDetail) {
        if let existing = favoriteCoins.first(where: { $0.id == coin.id }) {
            //            container.viewContext.delete(existing)
            context.delete(existing)
        } else {
            let newFav = FavoriteCoin(context: context)
            newFav.id = coin.id
            newFav.name = coin.name
            newFav.symbol = coin.symbol
            newFav.imageUrl = coin.image.small
        }
        save()
        fetchFavorites()
    }
    
    func save() {
        do {
            try context.save()
        } catch {
            print("Save error: \(error)")
        }
    }
}
