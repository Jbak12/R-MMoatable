//
//  MainListViewModel.swift
//  R&MMoatable
//
//  Created by Jakub Bakalarz on 19/05/2024.
//

import Foundation
import SwiftUI

class MainListViewModel: ObservableObject {
    private let dataService: RickAnMortyDataService
    @Published var characters: [Character] = []
    @Published var showingAlert = false
    @Published var lastError: Error? = nil
    @Published var isLoading = false
    @Published var isShowingInfo = false
    private var currentPage: Int = 1
    private var finishedFetch: Bool = false
    var isFirstPage: Bool {
        currentPage == 1
    }

    @MainActor
    func loadData() async {
        guard !isLoading || !finishedFetch else { return }
        isLoading = true
        do {
            let page = try await dataService.getPage(pageNumber: currentPage)
            characters.append(contentsOf: page.results)
            finishedFetch = page.info.next == nil
            currentPage += 1
        } catch {
            lastError = error
            showingAlert = true
        }
        isLoading = false
    }

    init(dataService: RickAnMortyDataService) {
        self.dataService = dataService
    }
}
