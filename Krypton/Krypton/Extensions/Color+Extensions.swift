//
//  Color+Extensions.swift
//  Krypton
//
//  Created by Marco Margarucci on 08/09/23.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let backGround = Color("BackgroundColor")
    let blue = Color("BlueColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
}
