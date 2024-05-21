//
//  MainListView.swift
//  R&MMoatable
//
//  Created by Jakub Bakalarz on 19/05/2024.
//
import SwiftUI

struct MainListView: View {
    @ObservedObject private var vm: MainListViewModel

    init(viewModel: MainListViewModel) {
        vm = viewModel
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.characters, id: \.id) { character in
                    NavigationLink(value: character) {
                        CharacterRowView(character: character)
                    }
                    .listRowBackground(Color.lightBackground)
                    .task {
                        if character == vm.characters.last && !vm.isLoading {
                            await vm.loadData()
                        }
                    }
                }
                HStack {
                    Spacer()
                    ProgressView {
                        Text("Loading...")
                    }
                    Spacer()
                }
            }

            .listStyle(.plain)
            .navigationDestination(for: Character.self) { selectedCharacter in
                CharacterDetailsView(viewModel: DetailViewModel(character: selectedCharacter))
            }

            .background(Color.lightBackground)
            .navigationTitle("Rick and Morty Characters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.rickBlue, for: .navigationBar)
            .toolbarColorScheme(.light, for: .navigationBar)
        }
        .alert(isPresented: $vm.showingAlert, withError: vm.error)
    }
}

// #Preview {
//    MainListView()
// }
