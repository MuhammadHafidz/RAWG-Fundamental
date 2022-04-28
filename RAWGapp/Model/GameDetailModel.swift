//
//  GameDetailModel.swift
//  RAWGapp
//
//  Created by Enygma System on 12/04/22.
//

import Foundation
struct GameDetailModel: Codable {
    let id: Int
    let name: String
    let releaseDate: String
    let rating: Double?
    let imageBackground: String?
    let image: String?
    let metacritic: Int?
    let playtime: Int?
    let esrbRating: String?
    let platforms: String?
    let genres: String?
    let developers: String?
    let publishers: String?
    let description: String?
    let urlWeb: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case releaseDate = "released"
        case rating
        case imageBackground = "background_image"
        case image = "background_image_additional"
        case metacritic = "metacritic"
        case playtime = "playtime"
        case esrbRating = "esrb_rating"
        case platforms
        case genres
        case developers
        case publishers
        case description = "description_raw"
        case urlWeb = "website"
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
        rating = try container.decodeIfPresent(Double.self, forKey: .rating)
        imageBackground = try container.decodeIfPresent(String.self, forKey: .imageBackground)
        image = try container.decodeIfPresent(String.self, forKey: .image)
        metacritic = try container.decodeIfPresent(Int.self, forKey: .metacritic)
        playtime = try container.decodeIfPresent(Int.self, forKey: .playtime)
        let esrbObj = try container.decodeIfPresent(Esrb.self, forKey: .esrbRating)
        esrbRating = esrbObj?.name
        if let platformArray = try container.decodeIfPresent([Platforms].self, forKey: .platforms) {
            platforms = platformArray.map {$0.platform.name}.joined(separator: ", ")
        } else {
            platforms = nil
        }
        if let genreArray = try container.decodeIfPresent([Genres].self, forKey: .genres) {
            genres = genreArray.map {$0.name}.joined(separator: ", ")
        } else {
            genres = nil
        }
        if let developerArray = try container.decodeIfPresent([Developers].self, forKey: .developers) {
            developers = developerArray.map {$0.name}.joined(separator: ", ")
        } else {
            developers = nil
        }
        if let publisherArray = try container.decodeIfPresent([Publishers].self, forKey: .publishers) {
            publishers = publisherArray.map {$0.name}.joined(separator: ", ")
        } else {
            publishers = nil
        }

        description = try container.decodeIfPresent(String.self, forKey: .description)
        urlWeb = try container.decodeIfPresent(String.self, forKey: .urlWeb)
    }
}

struct Platforms: Codable {
    let platform: Platform
}

struct Platform: Codable {
    let name: String
}

struct Genres: Codable {
    let name: String
}

struct Developers: Codable {
    let name: String
}

struct Publishers: Codable {
    let name: String
}

struct Esrb: Codable {
    let name: String
}
