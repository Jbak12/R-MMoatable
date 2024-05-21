//
//  ErrorHandler.swift
//  R&MMoatable
//
//  Created by Jakub Bakalarz on 21/05/2024.
//

import Foundation
import SwiftUI

extension View {
    func alert(isPresented: Binding<Bool>, withError error: Error?) -> some View {
        return alert(
            "Ups! :(",
            isPresented: isPresented,
            actions: {
                Button("Ok") {}
            }, message: {
                Text(error?.localizedDescription ?? "")
            }
        )
    }
}
