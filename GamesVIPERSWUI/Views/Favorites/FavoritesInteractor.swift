//
//  FavoritesInteractor.swift
//  GamesVIPERSWUI
//
//  Created by Jose Preatorian on 04-02-26.
//

import Foundation
import SwiftData

protocol FavoritesInteractorInputProtocol {
    func fetchFavoriteGames(localFavorites: [FavoriteGame])
}

class FavoritesInteractor: FavoritesInteractorInputProtocol {
    private let service: WebServiceGameProtocol
    weak var presenter: GamesInteractorOutputProtocol? // Reutilizamos el output de juegos
    
    init(service: WebServiceGameProtocol) {
        self.service = service
    }
    
    func fetchFavoriteGames(localFavorites: [FavoriteGame]) {
        let favoriteIDs = Set(localFavorites.map { $0.id })
        
        service.getGames(platform: .all, category: nil, sortBy: .popularity) { [weak self] result in
            switch result {
            case .success(let allGames):
                // Filtramos solo los que están en la base de datos local
                let filtered = allGames.filter { favoriteIDs.contains($0.id) }
                self?.presenter?.didFetchGames(.success(filtered))
            case .failure(let error):
                self?.presenter?.didFetchGames(.failure(error))
            }
        }
    }
}
