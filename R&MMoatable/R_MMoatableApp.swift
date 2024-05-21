//
//  R_MMoatableApp.swift
//  R&MMoatable
//
//  Created by Jakub Bakalarz on 19/05/2024.
//

import SwiftUI

@main
struct R_MMoatableApp: App {
    var body: some Scene {
        WindowGroup {
            MainViewFactory.makeMainView()
        }
    }
}
