//
//  ListRowView.swift
//  R&MMoatable
//
//  Created by Jakub Bakalarz on 21/05/2024.
//

import Foundation
import SwiftUI

private enum Constants {
    static let listHosrizontalSpacing: CGFloat = 20.0
    static let imgSize: CGSize = .init(width: 60, height: 60.0)
}

struct CharacterRowView: View {
    let character: Character

    var body: some View {
        HStack(spacing: Constants.listHosrizontalSpacing) {
            AsyncImageView(url: character.image, imageSize: Constants.imgSize)
            VStack(alignment: .leading, spacing: 5) {
                Text(character.name)
                    .font(.headline)
                Text("Status: \(character.status.rawValue)")
                    .font(.subheadline)
            }
        }
        .padding(.vertical, 5)
    }
}
