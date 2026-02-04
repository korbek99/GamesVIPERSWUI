//
//  GamesDetailsView.swift
//  GamesVIPERSWUI
//
//  Created by Jose Preatorian on 04-02-26.
//

import Foundation
import SwiftUI
import SwiftData

struct GamesDetailsView: View {
    @StateObject var presenter: GameDetailsPresenter
    @Query private var favorites: [FavoriteGame]
    
    private var isFavorite: Bool {
        favorites.contains { $0.id == presenter.game.id }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
            
                AsyncImage(url: presenter.game.thumbnail) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ZStack {
                        Color.gray.opacity(0.3)
                        ProgressView().tint(.yellow)
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 250)
                .clipped()
                .overlay(Rectangle().stroke(Color.yellow, lineWidth: 1))

                VStack(alignment: .leading, spacing: 20) {
                   
                    HStack(alignment: .top) {
                        Text(presenter.game.title)
                            .font(.system(size: 28, weight: .black, design: .monospaced))
                            .foregroundColor(.yellow)
                        
                        Spacer()
                        
                        Text(presenter.game.genre ?? "Game")
                            .font(.caption2)
                            .padding(.horizontal, 8).padding(.vertical, 4)
                            .background(Color.yellow).foregroundColor(.black)
                            .bold().cornerRadius(4)
                    }

             
                    infoBox
                    
                    Divider().background(Color.yellow.opacity(0.3))

   
                    VStack(alignment: .leading, spacing: 15) {
                        Text("RESUMEN")
                            .font(.headline).foregroundColor(.yellow)
                        Text(presenter.game.shortDescription ?? "Sin descripción.")
                            .font(.body).foregroundColor(.white.opacity(0.9)).lineSpacing(6)
                    }
                    
                    Spacer(minLength: 30)
                }
                .padding(.horizontal, 20).padding(.top, 20)
            }
        }
        .background(Color.black.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { presenter.favoriteButtonTapped() }) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(isFavorite ? .red : .yellow)
                        .font(.system(size: 18, weight: .bold))
                }
            }
        }
    }

    private var infoBox: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("INFO TÉCNICA").font(.caption).bold().foregroundColor(.yellow.opacity(0.8))
            Grid(alignment: .leading, horizontalSpacing: 20, verticalSpacing: 8) {
                detailRow(title: "PLATAFORMA", value: presenter.game.platform ?? "N/A")
                detailRow(title: "DESARROLLADOR", value: presenter.game.developer ?? "N/A")
                detailRow(title: "PUBLISHER", value: presenter.game.publisher ?? "N/A")
                detailRow(title: "LANZAMIENTO", value: presenter.game.releaseDate ?? "N/A")
            }
        }
        .padding().background(Color.white.opacity(0.05)).cornerRadius(10)
    }

    private func detailRow(title: String, value: String) -> some View {
        GridRow {
            Text(title).font(.system(size: 10, weight: .bold)).foregroundColor(.gray)
            Text(value).font(.system(size: 13)).foregroundColor(.white)
        }
    }
}
