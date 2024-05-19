//
//  Models.swift
//  R&MMoatable
//
//  Created by Jakub Bakalarz on 20/05/2024.
//

import Foundation

//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

struct Page<T: Codable>: Codable {
    let info: Info
    let results: [T]
}

struct Info: Codable {
    let count, pages: Int
    let next, prev: String
}

struct Character: Codable {
    let id: Int
    let name: String
    let status: Status
    let species, type: String
    let gender: Gender
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

struct Location: Codable {
    let name: String
    let url: String
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
