//
//  GamesRouter.swift
//  GamesVIPERSWUI
//
//  Created by Jose Preatorian on 04-02-26.
//

import Foundation
import SwiftUI

class GamesRouter {
    static func createModule() -> some View {
       
        let service = WebServiceGame()

        let interactor = GamesInteractor(service: service)
        let presenter = GamesPresenter()

        presenter.interactor = interactor
        interactor.presenter = presenter

        return GamesView(presenter: presenter)
    }
}
