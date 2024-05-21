//
//  CharacterDetailsView.swift
//  R&MMoatable
//
//  Created by Jakub Bakalarz on 20/05/2024.
//

import SwiftUI

struct CharacterDetailsView: View {
    @ObservedObject private var vm: DetailViewModel

    init(viewModel: DetailViewModel) {
        vm = viewModel
    }

    var body: some View {
        ZStack {
            Color.lightBackground.edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack(spacing: 20) {
                    AsyncImageView(url: vm.character.image, imageSize: .init(width: 100, height: 100))
                    Text(vm.character.name)
                        .font(.largeTitle)
                    Text("gender: " + vm.character.gender.rawValue)
                    Text("comes from " + vm.character.origin.name)
                    Text("last seen on " + vm.character.location.name)
                    if let firstEpisode = vm.episodes.first, let lastEpisode = vm.episodes.last {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("First Episode: \(firstEpisode.episode) - \(firstEpisode.name)")
                            Text("Last Episode: \(lastEpisode.episode) - \(lastEpisode.name)")
                        }
                        .font(.body)
                    }
                    Text("Appeared in \(vm.character.episode.count) episodes")
                        .font(.body)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.mortyYellow)
            .padding(.horizontal, 20)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton()
            }
        }
        .navigationBarBackground(Color.rickBlue)
        .task {
            await vm.fetchEpisode()
        }
    }
}

struct BackButton: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "arrow.backward.square")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                Text("Go back")
                    .foregroundColor(.black)
                    .fontDesign(.monospaced)
                    .fontWeight(.bold)
            }
        }
    }
}
