//
//  CharacterDetailsView.swift
//  R&MMoatable
//
//  Created by Jakub Bakalarz on 20/05/2024.
//

import SwiftUI

private enum Constants {
    static let imgSize: CGSize = .init(width: 150.0, height: 150.0)
    static let verticalSpacing: CGFloat = 20.0
    static let ImageDescriptionSpacing: CGFloat = 20.0
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
                VStack(alignment: .leading, spacing: Constants.verticalSpacing) {
                    HStack(alignment: .center, spacing: 40) {
                        CharacterImageView(url: vm.character.image, imageSize: Constants.imgSize)
                        Text(vm.character.name)
                            .primaryBoldTitle()
                    }
                    InfoLabel(label: "Gender", specifics: vm.character.gender.rawValue)
                    InfoLabel(label: "Comes from ", specifics: vm.character.origin.name)
                    InfoLabel(label: "Last seen on", specifics: vm.character.location.name)
                    InfoLabel(label: "Number of appearances", specifics: String(vm.character.episode.count))
                    if let firstEpisode = vm.selectedEpisodes.first, let lastEpisode = vm.selectedEpisodes.last {
                        InfoLabel(label: "First episode", specifics: "\(firstEpisode.episode) - \(firstEpisode.name)")
                        InfoLabel(label: "Last episode", specifics: "\(lastEpisode.episode) - \(lastEpisode.name)")
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
                BackButtonBasic()
            }
        }
        .navigationBarBackground(Color.rickBlue)
        .alert(isPresented: $vm.showingAlert, withError: vm.lastError)
        .refreshable {
            await vm.fetchEpisode()
        }
    }
}
