//
//  MainListView.swift
//  R&MMoatable
//
//  Created by Jakub Bakalarz on 19/05/2024.
//
import SwiftUI

struct MainNavigationTitle: View {
    let label: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .primaryBold()
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
                    if vm.isLoading {
                        HStack {
                            Spacer()
                            ProgressView {
                                Text("Loading...")
                            }
                            Spacer()
                        }
                    }
                }
                .listStyle(.plain)
                .background(Color.lightBackground)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        MainNavigationTitle(label: "Rick And Morty Characters") {
                            withAnimation {
                                proxy.scrollTo(vm.characters.first?.id ?? 0, anchor: .top)
                            }
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Image(systemName: "info.circle")
                            .onTapGesture {
                                vm.isShowingInfo.toggle()
                            }
                    }
                }
                .navigationDestination(for: Character.self) { selectedCharacter in
                    DetailViewFactory.makeDetailView(from: selectedCharacter)
                }
                .navigationBarBackground(Color.rickBlue)
                .refreshable {
                    guard vm.isFirstPage else { return }
                    await vm.loadData()
                }
                .sheet(isPresented: $vm.isShowingInfo, content: {
                    GeneralInfoView()
                })
            }
        }
        .alert(isPresented: $vm.showingAlert, withError: vm.lastError)
    }
}
