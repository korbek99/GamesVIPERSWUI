//
//  FavoritesRouter.swift
//  GamesVIPERSWUI
//
//  Created by Jose Preatorian on 04-02-26.
//

import Foundation
import SwiftUI
class FavoritesRouter {
    static func createModule() -> some View {
        let service = WebServiceGame()
        let interactor = FavoritesInteractor(service: service)
        let presenter = FavoritesPresenter()
        
        presenter.favoritesInteractor = interactor
        interactor.presenter = presenter
        
        return FavoritesView(presenter: presenter)
    }
}
