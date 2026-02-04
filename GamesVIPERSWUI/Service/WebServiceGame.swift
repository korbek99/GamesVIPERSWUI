//
//  WebServiceGame.swift
//  GamesVIPERSWUI
//
//  Created by Jose Preatorian on 04-02-26.
//

import Foundation

enum GamePlatform: String {
    case pc
    case browser
    case all
}

enum GameCategory: String {
    case mmorpg
    case shooter
    case pvp
    case mmofps
    case strategy
    case racing
    case sports
}

enum GameSort: String {
    case releaseDate = "release-date"
    case popularity
    case alphabetical
    case relevance
}

// MARK: - PROTOCOL
protocol WebServiceGameProtocol {
    func getGames(
        platform: GamePlatform?,
        category: GameCategory?,
        sortBy: GameSort?,
        completion: @escaping (Result<[Game], Error>) -> Void
    )
}

// MARK: - SERVICE
import Foundation

// MARK: - SERVICE
final class WebServiceGame: BaseService, WebServiceGameProtocol {
    

    private var baseURLString: String {
    
        guard let endpointData = getEndpoint(fromName: "crearIssue") else {
            return ""
        }
        return endpointData.url.absoluteString
    }

    func getGames(
        platform: GamePlatform? = nil,
        category: GameCategory? = nil,
        sortBy: GameSort? = nil,
        completion: @escaping (Result<[Game], Error>) -> Void
    ) {
   
        guard !baseURLString.isEmpty, var components = URLComponents(string: baseURLString) else {
            completion(.failure(NSError(domain: "Invalid Base URL", code: 400)))
            return
        }

        var queryItems: [URLQueryItem] = []

        if let platform {
            queryItems.append(URLQueryItem(name: "platform", value: platform.rawValue))
        }

        if let category {
            queryItems.append(URLQueryItem(name: "category", value: category.rawValue))
        }

        if let sortBy {
            queryItems.append(URLQueryItem(name: "sort-by", value: sortBy.rawValue))
        }

        components.queryItems = queryItems.isEmpty ? nil : queryItems


        guard let url = components.url else {
            completion(.failure(NSError(domain: "Invalid URL Components", code: 400)))
            return
        }

        print("🚀 Request GET:", url.absoluteString)

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "No data received", code: 0)))
                }
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let games = try decoder.decode([Game].self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(games))
                }
            } catch {
                print("❌ Decoding Error:", error)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
