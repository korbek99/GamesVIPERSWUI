//
//  GamesInteractor.swift
//  GamesVIPERSWUI
//
//  Created by Jose Preatorian on 04-02-26.
//

import Foundation

protocol GamesInteractorInputProtocol {
    func fetchGames(platform: GamePlatform, sortBy: GameSort)
}

protocol GamesInteractorOutputProtocol: AnyObject {
    func didFetchGames(_ result: Result<[Game], Error>)
}

class GamesInteractor: GamesInteractorInputProtocol {
    private let service: WebServiceGameProtocol
    weak var presenter: GamesInteractorOutputProtocol?
    
    init(service: WebServiceGameProtocol) {
        self.service = service
    }
    
    func fetchGames(platform: GamePlatform, sortBy: GameSort) {
        service.getGames(platform: platform, category: nil, sortBy: sortBy) { [weak self] result in
            self?.presenter?.didFetchGames(result)
        }
    }
}
