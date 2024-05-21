//
//  infoLabel.swift
//  R&MMoatable
//
//  Created by Jakub Bakalarz on 21/05/2024.
//

import SwiftUI

struct InfoLabel<SpecificsContent: View>: View {
    var label: String
    @ViewBuilder var specifics: () -> SpecificsContent

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(label)
                .primaryBold()
            specifics()
        }
    }
}

extension InfoLabel where SpecificsContent == Text {
    init(label: String, specifics: String) {
        self.label = label
        self.specifics = { Text(specifics).secondaryRegular() }
    }
}
