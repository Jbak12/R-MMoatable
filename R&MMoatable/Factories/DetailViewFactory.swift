//
//  DetailViewFactory.swift
//  R&MMoatable
//
//  Created by Jakub Bakalarz on 21/05/2024.
//

import Foundation

struct DetailViewFactory  {
    static func make(from character: Character) -> CharacterDetailsView {
        let service = DataService()
        let vm = DetailViewModel(character: character, service: service)
        let view = CharacterDetailsView(viewModel: vm)
        Task {
            await vm.fetchEpisode()
        }
        return view
    }
}

