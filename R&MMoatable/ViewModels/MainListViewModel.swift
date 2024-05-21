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
    @Published var error: Error?
    private var currentPage: Int = 1
    var isLoading = true

    func loadData() async {
//        guard !isLoading else { return }
        isLoading = true

        print("CURRENTPAGE: \(currentPage) ")
        do {
            let page = try await dataService.getPage(pageNumber: currentPage)
            await MainActor.run {
                characters.append(contentsOf: page.results)
            }
            currentPage += 1
        } catch {
            self.error = error
            showingAlert = true
        }

        isLoading = false
    }

    init(dataService: DataService) {
        self.dataService = dataService
    }
}
