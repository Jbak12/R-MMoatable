//
//  CharacterDetailsView.swift
//  R&MMoatable
//
//  Created by Jakub Bakalarz on 20/05/2024.
//

import SwiftUI

class DetailViewModel: ObservableObject {
    let character: Character

    init(character: Character) {
        self.character = character
    }
}


struct CharacterDetailsView: View {
    @StateObject private var vm: DetailViewModel

    init(viewModel: DetailViewModel) {
        _vm = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: URL(string: vm.character.image)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                } else if phase.error != nil {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .foregroundColor(.red)
                } else {
                    ProgressView()
                        .frame(width: 100, height: 100)
                }
            }
            Text(vm.character.name)
                .font(.largeTitle)
//            Text(vm.character.episode[0])
//                .font(.largeTitle)
            Text(vm.character.gender.rawValue)
                .font(.largeTitle)
            Text(vm.character.origin.name)
                .font(.largeTitle)
        }
        .padding()
    }
}

//#Preview {
//    CharacterDetailsView()
//}
