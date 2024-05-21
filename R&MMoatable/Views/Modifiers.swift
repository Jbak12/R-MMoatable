//
//  Modifiers.swift
//  R&MMoatable
//
//  Created by Jakub Bakalarz on 21/05/2024.
//

import Foundation
import SwiftUI

extension View {
    func navigationBarBackground(_ background: Color) -> some View {
        return modifier(ColoredNavigationBar(background: background))
    }
}

struct ColoredNavigationBar: ViewModifier {
    var background: Color

    func body(content: Content) -> some View {
        content
            .toolbarBackground(
                background,
                for: .navigationBar
            )
            .toolbarBackground(.visible, for: .navigationBar)
    }
}

extension Text {
    func primaryBold() -> Text {
        font(.system(size: 17, weight: .bold, design: .monospaced)).foregroundStyle(Color.primaryText)
    }

    func primaryBoldTitle() -> Text {
        font(.system(size: 30, weight: .bold, design: .monospaced)).foregroundStyle(Color.primaryText)
    }

    func primaryRegular() -> Text {
        font(.system(size: 16, weight: .regular, design: .monospaced)).foregroundStyle(Color.primaryText)
    }

    func secondaryRegular() -> Text {
        font(.system(size: 17, weight: .regular, design: .monospaced)).foregroundStyle(Color.secondaryText)
    }

    func secondaryRegular2() -> Text {
        font(.system(size: 13, weight: .regular, design: .monospaced)).foregroundStyle(Color.secondaryText)
    }
}
