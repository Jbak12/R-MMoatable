//
//  ListViewModel.swift
//  R&MMoatable
//
//  Created by Jakub Bakalarz on 19/05/2024.
//

import Foundation
class MainListViewModel: ObservableObject {
    @Published var characters: [String] = []
    func fetchData() async  {
        <#function body#>
    }
}
