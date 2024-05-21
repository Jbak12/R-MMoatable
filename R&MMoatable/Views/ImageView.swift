//
//  ImageView.swift
//  R&MMoatable
//
//  Created by Jakub Bakalarz on 21/05/2024.
//

import SwiftUI

struct AsyncImageView: View {
    let url: String
    let imageSize: CGSize

    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: imageSize.width, height: imageSize.height)
                    .clipShape(Circle())
            } else if phase.error != nil {
                Image(systemName: "xmark.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imageSize.width, height: imageSize.height)
                    .foregroundColor(.red)
            } else {
                ProgressView()
                    .frame(width: imageSize.width, height: imageSize.height)
            }
        }
    }
}

//
// #Preview {
//    AsyncImageView()
// }
