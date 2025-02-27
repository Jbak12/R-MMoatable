//
//  Page.swift
//  R&MMoatable
//
//  Created by Jakub Bakalarz on 21/05/2024.
//

import Foundation

struct Page<T: Codable>: Codable {
    let info: Info
    let results: [T]
}
