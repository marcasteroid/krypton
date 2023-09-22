//
//  KryptonApp.swift
//  Krypton
//
//  Created by Marco Margarucci on 08/09/23.
//

import SwiftUI

@main
struct KryptonApp: App {
    @StateObject private var viewModel = HomeViewModel()
    @Environment(\.scenePhase) var scenePhase
    @State var blurRadius : CGFloat = 0
    @State private var showLaunchView: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationView {
                    HomeView()
                        .toolbar(.hidden)
                        .blur(radius: blurRadius)
                        .onChange(of: scenePhase, perform: { value in
                            switch value {
                            case .active :
                                blurRadius = 0
                            case .inactive, .background:
                                blurRadius = 10
                            @unknown default:
                                debugPrint("unknown")
                            }
                        })
                }
                .environmentObject(viewModel)
                ZStack {
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
            }
        }
    }
}
