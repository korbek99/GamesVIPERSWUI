//
//  GamesPresenter.swift
//  GamesVIPERSWUI
//
//  Created by Jose Preatorian on 04-02-26.
//

import Foundation
import SwiftUI

class GamesPresenter: ObservableObject, GamesInteractorOutputProtocol {
    
    @Published var games: [Game] = []
    @Published var isLoading = false
    @Published var searchText = ""
    @Published var errorMessage: String? = nil
    
  
    @Published var selectedPlatform: GamePlatform = .all
    @Published var selectedSort: GameSort = .popularity
    
    var interactor: GamesInteractorInputProtocol?

   
    var filteredGames: [Game] {
        if searchText.isEmpty {
            return games
        } else {
            return games.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func getGames() {
        isLoading = true
        errorMessage = nil
        interactor?.fetchGames(platform: selectedPlatform, sortBy: selectedSort)
    }
    
    func didFetchGames(_ result: Result<[Game], Error>) {
        DispatchQueue.main.async {
            self.isLoading = false
            switch result {
            case .success(let fetchedGames):
                self.games = fetchedGames
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                self.games = []
            }
        }
    }
}
