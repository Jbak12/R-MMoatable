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
    @Published var showingAlert = false
    @Published var lastError: Error?
    var currentPage: Int = 1
    @Published var isLoading = false

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
            lastError = error
            showingAlert = true
        }

        isLoading = false
    }

    init(dataService: DataService) {
        self.dataService = dataService
    }
}
