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
        VStack {
            Spacer()
            onboardingItem
            Spacer()
            actionButton
        }
        .padding()
    }
    
    private var onboardingItem: some View {
        switch onboardingViewModel.currentScreen {
        case .newsInfo:
            return Text("news")
        case .missingsInfo:
            return Text("missings")
        case .welcome: return
            Text("welcome")
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
            Text("Дальше")
        })
    }
    
    private var closeButton: some View {
        Button(action: { onboardingViewModel.closeOnboarding() },
               label: {
            Text("Закрыть")
        })
    }
}
