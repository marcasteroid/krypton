//
//  LaunchView.swift
//  Krypton
//
//  Created by Marco Margarucci on 20/09/23.
//

import SwiftUI

struct LaunchView: View {
    // MARK: - Properties
    @State private var loadingText: [String] = LaunchViewConstants.loadingText.map { String($0) }
    @State private var showLoadingText: Bool = false
    @State private var counter: Int = 0
    @State private var loops: Int = 0
    @Binding var showLaunchView: Bool
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.launch.background
                .ignoresSafeArea()
            Image(GlobalConstants.logoImageName)
                .resizable()
                .frame(width: 80, height: 80)
            ZStack {
                if showLoadingText {
                    HStack(spacing: 0) {
                        ForEach(loadingText.indices) { index in
                            Text(loadingText[index])
                                .font(.info)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.theme.secondaryText)
                                .offset(y: counter == index ? -10 : 0)
                        }
                    }
                    .transition(AnyTransition.scale.animation(.interactiveSpring()))
                }
            }
            .offset(y: 50)
            .onAppear {
                showLoadingText.toggle()
            }
            .onReceive(timer) { _ in
                withAnimation(.spring()) {
                    let lastIndex = loadingText.count - 1
                    if counter == lastIndex {
                        counter = 0
                        loops += 1
                        if loops >= 3 {
                            showLaunchView = false
                        }
                    } else {
                        counter += 1
                    }
                }
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunchView: .constant(true))
    }
}
