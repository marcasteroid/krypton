//
//  UIApplication+Extension.swift
//  Krypton
//
//  Created by Marco Margarucci on 09/09/23.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
