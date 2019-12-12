//
//  GameAPIService.swift
//  GameStudyProd
//
//  Created by Eyup Kazım Göymen on 12.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Moya

typealias GameListResults      = (Result<[Game], NetworkError>) -> ()
typealias GameDetailResult = (Result<GameDetailResponse, NetworkError>) -> ()

protocol GameAPIServiceProtocol {
    func fetchGames(with pageNumber: Int, completion: @escaping GameListResults)
    func searchGame(with pageNumber: Int, keyword: String, completion: @escaping GameListResults)
    func fetchDetail(with gameId: Int, completion: @escaping GameDetailResult)
}

final class GameAPIService: GameAPIServiceProtocol {
    
    private let apiProvider = MoyaProvider<GameAPI>()
    
    func fetchGames(with pageNumber: Int, completion: @escaping (Result<[Game], NetworkError>) -> ()) {
        apiProvider.request(.fetchGames(pageNumber: pageNumber)) { (response) in
            switch response {
                case .success(let result):
                    do {
                        let gamesResponse = try JSONDecoder().decode(GameResponse.self, from: result.data)
                        completion(.success(gamesResponse.games))
                    } catch {
                        completion(.failure(NetworkError.parseError))
                    }
                
                case .failure(_):
                    completion(.failure(NetworkError.networkError))
            }
        }
    }
    
    func searchGame(with pageNumber: Int, keyword: String, completion: @escaping GameListResults) {
        apiProvider.request(.searchGames(pageNumber: pageNumber, keyword: keyword)) { (response) in
            switch response {
                case .success(let result):
                    do {
                        let gamesResponse = try JSONDecoder().decode(GameResponse.self, from: result.data)
                        completion(.success(gamesResponse.games))
                    } catch {
                        completion(.failure(NetworkError.parseError))
                    }
                
                case .failure(_):
                    completion(.failure(NetworkError.networkError))
            }
        }
    }
    
    func fetchDetail(with gameId: Int, completion: @escaping GameDetailResult) {
        apiProvider.request(.fetchDetail(gameId: gameId)) { (response) in
            switch response {
                case .success(let result):
                    do {
                        let gameDetailResponse = try JSONDecoder().decode(GameDetailResponse.self, from: result.data)
                        completion(.success(gameDetailResponse))
                    } catch {
                        completion(.failure(NetworkError.parseError))
                    }
                
                case .failure(_):
                    completion(.failure(NetworkError.networkError))
            }
        }
    }
}