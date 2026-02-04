//
//  GameDetailsRouter.swift
//  GamesVIPERSWUI
//
//  Created by Jose Preatorian on 04-02-26.
//

import Foundation
import SwiftUI
import SwiftData
class GameDetailsRouter {
    static func createModule(game: Game, context: ModelContext) -> some View {
        let presenter = GameDetailsPresenter(game: game)
        let interactor = GameDetailsInteractor(modelContext: context)
        
        presenter.interactor = interactor
        
        return GamesDetailsView(presenter: presenter)
    }
}
