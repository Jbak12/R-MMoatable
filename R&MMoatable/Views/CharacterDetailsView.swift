//
//  CharacterDetailsView.swift
//  R&MMoatable
//
//  Created by Jakub Bakalarz on 20/05/2024.
//

import SwiftUI

private enum Constants {
    static let imgSize: CGSize = .init(width: 150.0, height: 150.0)
}

struct CharacterDetailsView: View {
    @ObservedObject private var vm: DetailViewModel

    init(viewModel: DetailViewModel) {
        vm = viewModel
    }

    var body: some View {
        ZStack {
            Color.lightBackground.edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack(alignment: .center, spacing: 40) {
                        AsyncImageView(url: vm.character.image, imageSize: Constants.imgSize)
                        Text(vm.character.name)
                            .font(.largeTitle)
                            .foregroundColor(Color.primaryText)
                            .fontDesign(.monospaced)
                    }
                    infoLabel(label: "Gender", specifics: vm.character.gender.rawValue)
                    infoLabel(label: "Comes from ", specifics: vm.character.origin.name)
                    infoLabel(label: "Last seen on", specifics: vm.character.location.name)
                    infoLabel(label: "Number of appearances", specifics: String(vm.character.episode.count))
                    if let firstEpisode = vm.episodes.first, let lastEpisode = vm.episodes.last {
                        infoLabel(label: "First episode", specifics: "\(firstEpisode.episode) - \(firstEpisode.name)")
                        infoLabel(label: "Last episode", specifics: "\(lastEpisode.episode) - \(lastEpisode.name)")
                    }
                }
                .padding(.top, 20)
                .padding(.leading, 10)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.mortyYellow)
            .padding(.horizontal, 20)
            .scrollIndicators(.never)
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

struct infoLabel: View {
    var label: String
    var specifics: String
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(label)
                .fontDesign(.monospaced)
                .foregroundStyle(Color.primaryText)
                .fontWeight(.bold)
            Text(specifics)
                .fontDesign(.monospaced)
                .foregroundStyle(Color.secondaryText)
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
