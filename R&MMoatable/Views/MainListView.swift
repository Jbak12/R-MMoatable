//
//  MainListView.swift
//  R&MMoatable
//
//  Created by Jakub Bakalarz on 19/05/2024.
//
import SwiftUI

extension View {
    func navigationBarBackground(_ background: Color) -> some View {
        return modifier(ColoredNavigationBar(background: background))
    }
}

struct ColoredNavigationBar: ViewModifier {
    var background: Color

    func body(content: Content) -> some View {
        content
            .toolbarBackground(
                background,
                for: .navigationBar
            )
            .toolbarBackground(.visible, for: .navigationBar)
    }
}

struct MainNavigationTitle: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("Rick and Morty Characters")
                .font(.headline)
                .foregroundColor(.primary)
                .fontDesign(.monospaced)
                .fontWeight(.bold)
        }
    }
}

struct MainListView: View {
    @ObservedObject private var vm: MainListViewModel

    init(viewModel: MainListViewModel) {
        vm = viewModel
    }

    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
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
                .background(Color.lightBackground)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        MainNavigationTitle {
                            withAnimation {
                                proxy.scrollTo(vm.characters.first?.id ?? 0, anchor: .top)
                            }
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Image(systemName: "info.circle")
                    }
                }
                .navigationDestination(for: Character.self) { selectedCharacter in
                    DetailViewFactory.make(from: selectedCharacter)
                }
                .navigationBarBackground(Color.rickBlue)
            }
        }
        .alert(isPresented: $vm.showingAlert, withError: vm.error)
    }
}
