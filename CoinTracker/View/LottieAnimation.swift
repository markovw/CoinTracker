//
//  LottieAnimation.swift
//  CoinTracker
//
//  Created by Vladislav on 28.07.2024.
//

import SwiftUI
import Lottie
import AuthenticationServices

struct LottieAnimation: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            LottieView(animation: .named("LoginAnimation"))
                .configure( { lottieAnimationView in
                    lottieAnimationView.contentMode = .scaleAspectFit
                })
                .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
                .animationDidFinish { completed in
                    
                }
            VStack {
                NavigationLink {
                    MarketTab()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    SignInWithAppleButton(.continue) { request in
                        
                    } onCompletion: { result in
                        
                    }
                    .signInWithAppleButtonStyle(
                        colorScheme == .dark ? .white : .black
                    )
                    .frame(height: 50)
                    .padding()
                    .cornerRadius(10)

                }
                

            }
        }
    }
}

#Preview {
    LottieAnimation()
}
