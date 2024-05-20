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
        List {
            ForEach(vm.characters, id:\.id) { character in
                Text(character.name)
            }
            
        }
        
        Button(action: {
            Task {
                await vm.loadData()
            }
        }, label: {
            Text("+")
                .cornerRadius(3.0)
                .frame(width: 300)
                .background(.green)

        })

    }
}

#Preview {
    MainListView()
}
