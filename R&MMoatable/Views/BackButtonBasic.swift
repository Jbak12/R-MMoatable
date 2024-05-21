//
//  BackButtonBasic.swift
//  R&MMoatable
//
//  Created by Jakub Bakalarz on 21/05/2024.
//

import SwiftUI

struct BackButtonBasic: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "arrow.backward.square")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.primaryText)
                    .fontWeight(.bold)
                Text("Go back")
                    .primaryBold()
            }
        }
    }
}
