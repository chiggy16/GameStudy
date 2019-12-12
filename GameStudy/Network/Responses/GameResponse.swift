//
//  GameResponse.swift
//  GameStudy
//
//  Created by Eyup Kazım Göymen on 12.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Foundation

struct GameResponse: Decodable {
    var games: [Game]
    
    enum CodingKeys: String, CodingKey {
        case games = "results"
    }
}

struct Game: Decodable {
    let id: Int
    let name: String
    let rating: Double
    let backgroundImageUrl: String
    let genres: [Genre]
    
    enum CodingKeys: String, CodingKey {
        case id, name, rating, genres
        case backgroundImageUrl = "background_image"
    }
    
}

struct Genre: Decodable {
    let name: String
}