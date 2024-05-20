//
//  Colors.swift
//  R&MMoatable
//
//  Created by Jakub Bakalarz on 20/05/2024.
//

import Foundation
import SwiftUI

extension Color {
    static let rickBlue = Color(hex: "#41B3F9")
    static let mortyYellow = Color(hex: "#F9E79F")
    static let alienGreen = Color(hex: "#66FF66")
    static let portalGreen = Color(hex: "#00FF00")
    static let lightBackground = Color(hex: "#F5F5F5")
    static let darkBackground = Color(hex: "#2E2E2E")
    static let primaryText = Color(hex: "#000000")
    static let secondaryText = Color(hex: "#757575")
    static let lightText = Color(hex: "#FFFFFF")
    static let redAlert = Color(hex: "#FF4C4C")
    static let successGreen = Color(hex: "#28A745")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8 * 1) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
