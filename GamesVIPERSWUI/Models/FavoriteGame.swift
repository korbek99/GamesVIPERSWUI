//
//  FavoriteGame.swift
//  GamesVIPERSWUI
//
//  Created by Jose Preatorian on 04-02-26.
//

import Foundation
import SwiftData

@Model
final class FavoriteGame {
    @Attribute(.unique) var id: Int
    var title: String
    var thumbnailURL: String
    var genre: String?
    
    init(id: Int, title: String, thumbnailURL: String, genre: String) {
        self.id = id
        self.title = title
        self.thumbnailURL = thumbnailURL
        self.genre = genre
    }
}
