//
//  HelpModels.swift
//  R&MMoatable
//
//  Created by Jakub Bakalarz on 20/05/2024.
//

import Foundation

struct Info: Codable {
    let count, pages: Int
    let next, prev: String?
}

struct Location: Codable {
    let name: String
    let url: String
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown
    case genderLess = "Genderless"
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown
}
