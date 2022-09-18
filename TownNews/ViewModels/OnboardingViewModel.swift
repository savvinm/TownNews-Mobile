//
//  OnboardingViewModel.swift
//  TownNews
//
//  Created by Maksim Savvin on 18.09.2022.
//

import Foundation

class OnboardingViewModel: ObservableObject {
    enum OnboardingScreen: CaseIterable {
        case welcome
        case newsInfo
        case missingsInfo
        
        var isNextExist: Bool {
            switch self {
            case .welcome, .newsInfo:
                return true
            case .missingsInfo:
                return false
            }
        }
    }
    
    let allCases = OnboardingScreen.allCases
    @Published private(set) var isDoneOnboarding = false
    @Published private(set) var currentScreen: OnboardingScreen
    
    init() {
        currentScreen = allCases.first!
    }
    
    func showNextScreen() {
        guard let index = allCases.firstIndex(of: currentScreen) else {
            return
        }
        currentScreen = allCases[index + 1]
    }
    
    func closeOnboarding() {
        isDoneOnboarding = true
    }
    
}
