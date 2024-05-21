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
            CharacterImageView(url: character.image, imageSize: Constants.imgSize)
            VStack(alignment: .leading, spacing: 5) {
                Text(character.name)
                    .primaryRegular()
                Text("Status: \(character.status.rawValue)")
                    .secondaryRegular2()
            }
        }
        .padding(.vertical, 5)
    }
}
