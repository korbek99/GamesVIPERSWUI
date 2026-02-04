//
//  GameDetailsPresenter.swift
//  GamesVIPERSWUI
//
//  Created by Jose Preatorian on 04-02-26.
//

import Foundation

class GameDetailsPresenter: ObservableObject {
    let game: Game
    var interactor: GameDetailsInteractorInputProtocol?
    
    init(game: Game) {
        self.game = game
    }
    
    func favoriteButtonTapped() {
        interactor?.toggleFavorite(game: game)
    }
}
