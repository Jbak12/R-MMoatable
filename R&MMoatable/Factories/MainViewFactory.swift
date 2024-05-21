//
//  MainViewFactory.swift
//  R&MMoatable
//
//  Created by Jakub Bakalarz on 21/05/2024.
//

import Foundation

enum MainViewFactory {
    static func makeMainView() -> MainListView {
        let service = DataService()
        let vm = MainListViewModel(dataService: service)
        let view = MainListView(viewModel: vm)
        Task {
            await vm.loadData()
        }
        return view
    }
}
