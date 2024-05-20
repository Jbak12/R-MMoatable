//
//  MainListViewModel.swift
//  R&MMoatable
//
//  Created by Jakub Bakalarz on 19/05/2024.
//

import Foundation
import SwiftUI

class MainListViewModel: ObservableObject {
    let dataService: DataService
    @Published var characters: [Character] = []
    @Published var showingAlert = true
    private var currentPage: Int = 1
    var isLoading = false
    @Published var selectedCharacter: Character?

    @MainActor
    func loadData() async {
        guard !isLoading else { return }
        isLoading = true

        print("CURRENTPAGE: \(currentPage) ")
        do {
            let page = try await dataService.getPage(pageNumber: currentPage)
            characters.append(contentsOf: page.results)
            currentPage += 1
        } catch {
            print("Failed to load data: \(error.localizedDescription)")
        }

        isLoading = false
    }

    func selectCharacter(_ character: Character) {
        selectedCharacter = character
    }

    func deselectCharacter() {
        selectedCharacter = nil
    }

    init(dataService: DataService) {
        self.dataService = dataService
    }
}
