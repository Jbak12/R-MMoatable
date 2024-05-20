//
//  MainListView.swift
//  R&MMoatable
//
//  Created by Jakub Bakalarz on 19/05/2024.
//

import SwiftUI

private enum Constants {
    static let listHosrizontalSpacing: CGFloat = 20.0
    static let imgSize: CGFloat = 50.0
}

struct CharacterRowView: View {
    let character: Character

    var body: some View {
        HStack(spacing: Constants.listHosrizontalSpacing) {
            AsyncImage(url: URL(string: character.image)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: Constants.imgSize, height: Constants.imgSize)
                        .clipShape(Circle())
                } else if phase.error != nil {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: Constants.imgSize, height: Constants.imgSize)
                        .foregroundColor(.red)
                } else {
                    ProgressView()
                        .frame(width: Constants.imgSize, height: Constants.imgSize)
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
    }
}

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
        .alert(isPresented: $vm.showingAlert) {
            Alert(title: Text("ziomal"))
        }
    }
}

// struct MainListView: View {
//    @ObservedObject private var vm: MainListViewModel
//
//    init(viewModel: MainListViewModel) {
//        vm = viewModel
//    }
//
//    var body: some View {
//        NavigationStack {
//            List {
//                ForEach(vm.characters, id: \.id) { character in
//                    HStack(spacing: Constants.listHosrizontalSpacing) {
//                        AsyncImage(url: URL(string: character.image)) { phase in
//                            if let image = phase.image {
//                                image
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: Constants.imgSize, height: Constants.imgSize)
//                                    .clipShape(Circle())
//                            } else if phase.error != nil {
//                                Image(systemName: "xmark.circle")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: Constants.imgSize, height: Constants.imgSize)
//                                    .foregroundColor(.red)
//                            } else {
//                                ProgressView()
//                                    .frame(width: Constants.imgSize, height: Constants.imgSize)
//                            }
//                        }
//                        VStack(alignment: .leading, spacing: 5) {
//                            Text(character.name)
//                                .font(.headline)
//                            Text(character.status.rawValue)
//                                .font(.subheadline)
//                        }
//                    }
//                    .padding(.vertical, 5)
//                    .onTapGesture {
//                        vm.selectCharacter(character)
//                    }
//                    .task {
//                        if character == vm.characters.last && !vm.isLoading {
//                            await vm.loadData()
//                        }
//                    }
//                }
//                if vm.isLoading {
//                    HStack {
//                        Spacer()
//                        ProgressView()
//                        Spacer()
//                    }
//                }
//            }
//            .listStyle(.plain)
//            //            .navigationTitle("Characters")
//            .safeAreaInset(edge: .top) {
//                Text("RICK AND MORTY INTERNSHIP APP")
//                    .font(.title3)
//                    .fontDesign(.monospaced)
//                    .foregroundStyle(.white)
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(.yellow)
//            }
//            .navigationDestination(isPresented: Binding<Bool>(
//                get: { vm.selectedCharacter != nil },
//                set: { if !$0 { vm.deselectCharacter() } }
//            )) {
//                if let selectedCharacter = vm.selectedCharacter {
//                    CharacterDetailsView(viewModel: DetailViewModel(character: selectedCharacter))
//                }
//            }
//            .alert(isPresented: $vm.showingAlert, content: {
//                Alert(title: Text("ziomal"))
//            })
//
//
//        }
//    }
// }
// #Preview {
//    MainListView()
// }
