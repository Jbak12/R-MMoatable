//
//  DataService.swift
//  R&MMoatable
//
//  Created by Jakub Bakalarz on 19/05/2024.
//

import Foundation

class DataService {
    func getPage(pageNumber: Int) async throws -> Page<Character>  {
        let urlString = URLProvider.charactersURL + "/?page=\(pageNumber)"
        guard let url: URL = URL(string: urlString) else { throw URLError(.badURL) }
        do {
            let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
            let page = try JSONDecoder().decode(Page<Character>.self, from: data)
            return page
        } catch {
            print(error)
            throw error
        }
    }
}
