//
//  ShowInfoView.swift
//  R&MMoatable
//
//  Created by Jakub Bakalarz on 21/05/2024.
//

import SwiftUI

struct GeneralInfoView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                Image("rm")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .frame(height: 300)

                Text("Rick and Morty")
                    .primaryBoldTitle()

                Text("Overview")
                    .primaryBold()

                Text("""
                "Rick and Morty" is an American adult animated science fiction sitcom. Series follows the misadventures of cynical mad scientist Rick Sanchez and his good-hearted but fretful grandson Morty Smith.
                """)
                .secondaryRegular()
                Text("About app")
                    .primaryBold()
                Text("""
                This app Uses Rick and morty public API, its main goal is to show list of characters from the show. App also can display more detailed character screen.
                """)
                .secondaryRegular()

                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .background(Color.mortyYellow)
    }
}

struct GeneralInfoView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralInfoView()
    }
}
