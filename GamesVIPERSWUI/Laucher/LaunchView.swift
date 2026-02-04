//
//  LaunchView.swift
//  GamesVIPERSWUI
//
//  Created by Jose Preatorian on 04-02-26.
//

import SwiftUI

struct LaunchView: View {
    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 0
    @State private var isActive = false
    @State private var glowOpacity: Double = 0

    var body: some View {
        if isActive {
            HomeView()
        } else {
            ZStack {
 
                LinearGradient(colors: [Color(white: 0.1), .black],
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea()

                VStack(spacing: 25) {

                    ZStack {
 
                        Image(systemName: "gamecontroller.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .foregroundColor(.red.opacity(0.5))
                            .blur(radius: 20)
                            .opacity(glowOpacity)
                        
                        Image(systemName: "gamecontroller.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .foregroundColor(.white)
                            .shadow(color: .red, radius: 10)
                    }
                    .scaleEffect(scale)
                    .opacity(opacity)

                    VStack(spacing: 8) {
                        Text("Gamers")
                            .font(.system(size: 42, weight: .black, design: .monospaced))
                            .foregroundColor(.white)
                            .tracking(5)
                        
                        Text("Game Paradise")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.red)
                            .tracking(2)
                    }
                    .opacity(opacity)
                    .offset(y: opacity == 1 ? 0 : 20)
                }

                VStack {
                    Spacer()
                    ProgressView()
                        .tint(.red)
                        .scaleEffect(1.2)
                        .opacity(opacity)
                        .padding(.bottom, 50)
                }
            }
            .onAppear {
                
                withAnimation(.spring(response: 0.8, dampingFraction: 0.6, blendDuration: 0)) {
                    scale = 1.0
                    opacity = 1.0
                }

                withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                    glowOpacity = 1.0
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    LaunchView()
}

