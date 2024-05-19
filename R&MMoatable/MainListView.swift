//
//  MainListView.swift
//  R&MMoatable
//
//  Created by Jakub Bakalarz on 19/05/2024.
//

import SwiftUI

struct MainListView: View {
    
    @StateObject private var vm: MainListViewModel = MainListViewModel()
     
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .task {
                <#code#>
            }
    }
}

#Preview {
    MainListView()
}
