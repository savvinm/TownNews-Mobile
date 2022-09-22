//
//  OnboardingView.swift
//  TownNews
//
//  Created by Maksim Savvin on 18.09.2022.
//

import SwiftUI

struct OnboardingView: View {
    @ObservedObject var onboardingViewModel: OnboardingViewModel
    var body: some View {
        ZStack(alignment: .bottom) {
            onboardingItem
            actionButton
                .padding()
        }
        .padding()
    }
    
    private var onboardingItem: some View {
        switch onboardingViewModel.currentScreen {
        case .newsInfo:
            return OnboardingScreen(imageName: "newsIcon", description: "Читайте последние новости города и первыми узнавайте о важных событиях", imageSize: 0.4)
        case .missingsInfo:
            return OnboardingScreen(imageName: "missingIcon", description: "Создавайте объявления о пропаже и помогайте людям найти их родных и близких", imageSize: 0.4)
        case .welcome:
            return OnboardingScreen(imageName: "AppIcon", description: "TownNews - приложение для вашего города", imageSize: 0.3)
        }
    }
    
    private var actionButton: some View {
        VStack {
            if onboardingViewModel.currentScreen.isNextExist {
                nextButton
            } else {
                closeButton
            }
        }
    }
    
    private var nextButton: some View {
        Button(action: { onboardingViewModel.showNextScreen() },
               label: {
            Text("Далее")
                .foregroundColor(.white)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(.cyan)
                        .frame(width: UIScreen.main.bounds.width * 0.8)
                }
        })
        .buttonStyle(PlainButtonStyle())
    }
    
    private var closeButton: some View {
        Button(action: { onboardingViewModel.closeOnboarding() },
               label: {
            Text("Закрыть")
                .foregroundColor(.white)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(.cyan)
                        .frame(width: UIScreen.main.bounds.width * 0.8)
                }
        })
        .buttonStyle(PlainButtonStyle())
    }
}
