//
//  GameModel.swift
//  RAWGapp
//
//  Created by Enygma System on 12/04/22.
//

import Foundation

struct GameResponse: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [GameModel]?
}

struct GameModel: Codable {
    let id: Int
    let name: String
    let releaseDate: String
    let rating: Double
    let imageBackground: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case releaseDate = "released"
        case rating
        case imageBackground = "background_image"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        let dateString = try container.decode(String.self, forKey: .releaseDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateString)!
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "MMM, d YY"
        releaseDate = dateFormatter1.string(from: date)
        rating = try container.decode(Double.self, forKey: .rating)
        imageBackground = try container.decodeIfPresent(String.self, forKey: .imageBackground)
    }

    init(id: Int, name: String, releaseDate: String, rating: Double, imageBackground: String) {
        self.id = id
        self.name = name
        self.releaseDate = releaseDate
        self.rating = rating
        self.imageBackground = imageBackground
    }
}

let gameTestData = GameModel(
    id: 3498,
    name: "Grand Theft Auto V",
    releaseDate: "Sep,17 2013",
    rating: 4.48,
    imageBackground: "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg"
)
