//
//  Model.swift
//  table
//
//  Created by Алексей Волобуев on 29.09.2022.
//

import Foundation
import UIKit

struct Response: Codable {
    var info: Info
    var episodes: [Episode]
    
    enum CodingKeys: String, CodingKey {
        case info
        case episodes = "results"
    }
}

struct Episode: Codable {
    var id: Int
    var name: String
    var airDate: String
    var episode: String
    var characters: [String]
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case airDate = "air_date"
        case episode
        case characters
        case url
    }
}

struct Info: Codable {
    var count: Int
    var pages: Int
    //var next: String
    //var prev: String
}

struct Character: Codable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var gender: String
    var origin: LocationLink
    var location: LocationLink
    var image: String
    var episode: [String]
    var url: String
}

struct LocationLink: Codable {
    var name: String
    var url: String
}

struct Location: Codable {
    var id: Int
    var name: String
    var type: String
    var dimension: String
    var residents: [String]
}

enum CustomCellType{
    case photo
    case info
    case episodes
    case location
}

struct EpisodeViewModel {
    var episodeName: String
    var episodeCharacterLinks: [String]
}

struct CharacterViewModel {
    var name: String
    var image: UIImage
}

struct CharacterInfoViewModel {
    var name: String
    var status: String
    var species: String
    var gender: String
    var origin: LocationLink
    var location: LocationLink
    var image: UIImage
    var episode: [String]
}

struct LocationViewModel {
    var location: Location
    var characters: [CharacterViewModel]
}
