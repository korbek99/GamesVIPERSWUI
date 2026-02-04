//
//  FavoritesView.swift
//  GamesVIPERSWUI
//
//  Created by Jose Preatorian on 04-02-26.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    @StateObject var presenter: FavoritesPresenter
    @Query private var favoriteEntities: [FavoriteGame]
    @Environment(\.modelContext) private var modelContext
    
    init(presenter: FavoritesPresenter) {
        _presenter = StateObject(wrappedValue: presenter)
        UICollectionView.appearance().backgroundColor = .clear
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    if presenter.isLoading && presenter.games.isEmpty {
                        loadingState
                    } else if favoriteEntities.isEmpty {
                        emptyState
                    } else {
                        favoritesList
                    }
                }
            }
            .navigationTitle("MIS FAVORITOS")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color.black, for: .navigationBar)
        }
        .onAppear {
            presenter.getFavorites(localFavorites: favoriteEntities)
        }
  
        .onChange(of: favoriteEntities) { _ in
            presenter.getFavorites(localFavorites: favoriteEntities)
        }
    }

    private var favoritesList: some View {
        List(presenter.games) { game in
            NavigationLink(destination: GameDetailsRouter.createModule(game: game, context: modelContext)) {
                gameRow(game: game)
            }
            .listRowBackground(Color.black)
            .listRowSeparatorTint(.yellow.opacity(0.3))
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }

    private var loadingState: some View {
        VStack {
            Spacer()
            ProgressView().tint(.yellow).scaleEffect(1.5)
            Text("SINCRONIZANDO...").foregroundColor(.yellow).padding()
            Spacer()
        }
    }

    private var emptyState: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(systemName: "heart.slash.fill").font(.system(size: 50)).foregroundColor(.yellow.opacity(0.5))
            Text("NO TIENES FAVORITOS").font(.headline).foregroundColor(.white)
            Spacer()
        }
    }

    @ViewBuilder
    private func gameRow(game: Game) -> some View {
        HStack(alignment: .top, spacing: 15) {
            AsyncImage(url: game.thumbnail) { phase in
                if let image = phase.image {
                    image.resizable().aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 70).cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.yellow.opacity(0.5), lineWidth: 1))
                } else {
                    RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.2)).frame(width: 120, height: 70)
                }
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(game.title).font(.headline).foregroundColor(.yellow).lineLimit(1)
                Text(game.genre ?? "Action").font(.subheadline).foregroundColor(.white)
                HStack {
                    Image(systemName: "heart.fill").font(.caption2).foregroundColor(.red)
                    Text(game.platform ?? "PC").font(.caption2).foregroundColor(.gray)
                }
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    FavoritesRouter.createModule()
        .modelContainer(for: FavoriteGame.self, inMemory: true)
}
