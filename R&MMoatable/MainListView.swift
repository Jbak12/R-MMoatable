//
//  MainListView.swift
//  R&MMoatable
//
//  Created by Jakub Bakalarz on 19/05/2024.
//

import SwiftUI

struct MainListView: View {
    @StateObject private var vm: MainListViewModel

    init(viewModel: MainListViewModel) {
        _vm = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.characters, id: \.id) { character in
                    HStack(spacing: 20) {
                        AsyncImage(url: URL(string: character.image)) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            } else if phase.error != nil {
                                Image(systemName: "xmark.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.red)
                            } else {
                                ProgressView()
                                    .frame(width: 50, height: 50)
                            }
                        }
                        VStack(alignment: .leading, spacing: 5) {
                            Text(character.name)
                                .font(.headline)
                            Text(character.status.rawValue)
                                .font(.subheadline)
                        }
                    }
                    .padding(.vertical, 5)
                    .onTapGesture {
                        vm.selectCharacter(character)
                    }
                    .task {
                        if character == vm.characters.last && !vm.isLoading {
                            await vm.loadData()
                        }
                    }
                }
                if vm.isLoading {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                }
            }
            .listStyle(.plain)
//            .navigationTitle("Characters")
            .safeAreaInset(edge: .top) {
                   Text("RICK AND MORTY INTERNSHIP APP")
                           .font(.title3)
                           .fontDesign(.monospaced)
                           .foregroundStyle(.white)
                           .frame(maxWidth: .infinity)
                           .padding()
                           .background(.yellow)
            }
            .navigationDestination(isPresented: Binding<Bool>(
                get: { vm.selectedCharacter != nil },
                set: { if !$0 { vm.deselectCharacter() } }
            )) {
                if let selectedCharacter = vm.selectedCharacter {
                    CharacterDetailsView(viewModel: DetailViewModel(character: selectedCharacter))
                }
            }
            .onAppear {
                Task {
                    await vm.loadData()
                }
            }
            .alert(isPresented: $vm.showingAlert, content: {
                Alert(title: Text("ziomal"))
            })
        }
    }
}

//#Preview {
//    MainListView()
//}
