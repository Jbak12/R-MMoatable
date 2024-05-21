//
//  Episode.swift
//  R&MMoatable
//
//  Created by Jakub Bakalarz on 21/05/2024.
//

import Foundation

struct Episode: Codable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case airDate = "air_date"
        case episode
        case url
    }
}

// extension Episode: ApiModelProtocol{
//    static var urlString: String{
//        return "https://rickandmortyapi.com/api/episode"
//    }
// }

// extension Episode {
//    var numberOfCharacters: Int {
//        characters.count
//    }
// }
