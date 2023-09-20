//
//  String+Extensions.swift
//  Krypton
//
//  Created by Marco Margarucci on 20/09/23.
//

import Foundation

extension String {
    
    var isNotEmpty: Bool {
        return !self.isEmpty
    }
    
    var removingHTMLOccurrences: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
