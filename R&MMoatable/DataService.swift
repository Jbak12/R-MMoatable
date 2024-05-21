//
//  DataService.swift
//  R&MMoatable
//
//  Created by Jakub Bakalarz on 19/05/2024.
//

import Foundation

protocol RickAnMortyDataService {
    func getPage(pageNumber: Int) async throws -> Page<Character>
    func getEpisode(episodeURL: String) async throws -> Episode
}

class DataService: RickAnMortyDataService {
    func getPage(pageNumber: Int) async throws -> Page<Character> {
        let urlString = URLProvider.charactersURL + "/?page=\(pageNumber)"
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        do {
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            let page = try JSONDecoder().decode(Page<Character>.self, from: data)
            return page
        } catch {
            throw error
        }
    }

    func getEpisode(episodeURL: String) async throws -> Episode {
        guard let url = URL(string: episodeURL) else { throw URLError(.badURL) }
        do {
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            let episode = try JSONDecoder().decode(Episode.self, from: data)
            return episode
        } catch {
            throw error
        }
    }
}
