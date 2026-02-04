//
//  GameDetailsInteractor.swift
//  GamesVIPERSWUI
//
//  Created by Jose Preatorian on 04-02-26.
//

import Foundation
import SwiftData

protocol GameDetailsInteractorInputProtocol {
    func toggleFavorite(game: Game)
}

class GameDetailsInteractor: GameDetailsInteractorInputProtocol {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func toggleFavorite(game: Game) {
        let id = game.id
        // Buscamos si ya existe
        let descriptor = FetchDescriptor<FavoriteGame>(predicate: #Predicate { $0.id == id })
        
        if let existingFavorites = try? modelContext.fetch(descriptor), let favorite = existingFavorites.first {
            modelContext.delete(favorite)
        } else {
            let newFavorite = FavoriteGame(
                id: game.id,
                title: game.title,
                thumbnailURL: game.thumbnail?.absoluteString ?? "",
                genre: game.genre!
            )
            modelContext.insert(newFavorite)
        }
        try? modelContext.save()
    }
}
