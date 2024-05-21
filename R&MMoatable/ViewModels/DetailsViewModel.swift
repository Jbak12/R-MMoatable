//
//  DetailsViewModel.swift
//  R&MMoatable
//
//  Created by Jakub Bakalarz on 21/05/2024.
//

import Foundation

class DetailViewModel: ObservableObject {
    let character: Character
    private let service: RickAnMortyDataService
    @Published var selectedEpisodes: [Episode] = []
    @Published var lastError: Error? = nil
    @Published var showingAlert = false

    init(character: Character, service: DataService) {
        self.character = character
        self.service = service
    }

    @MainActor
    func fetchEpisode() async {
        do {
            guard character.episode.count > 0 else { return }
            let (firstEpisodeURLString, lastEpisodeURLString) = (character.episode.first!, character.episode.last!)
            async let episode1Fetch = service.getEpisode(episodeURL: firstEpisodeURLString)
            async let episode2Fetch = service.getEpisode(episodeURL: lastEpisodeURLString)
            let (e1, e2) = try await (episode1Fetch, episode2Fetch)
            selectedEpisodes.append(contentsOf: [e1, e2])
        } catch {
            lastError = error
            showingAlert = true
        }
    }
}
