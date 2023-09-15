//
//  HapticManager.swift
//  Krypton
//
//  Created by Marco Margarucci on 15/09/23.
//

import Foundation
import SwiftUI

class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(feedbackType: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(feedbackType)
    }
}
