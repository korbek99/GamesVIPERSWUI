//
//  FavoritesPresenter.swift
//  GamesVIPERSWUI
//
//  Created by Jose Preatorian on 04-02-26.
//

import Foundation
class FavoritesPresenter: GamesPresenter {
    var favoritesInteractor: FavoritesInteractorInputProtocol?
    
    func getFavorites(localFavorites: [FavoriteGame]) {
        self.isLoading = true
        favoritesInteractor?.fetchFavoriteGames(localFavorites: localFavorites)
    }
}
