//
//  TownNewsApp.swift
//  TownNews
//
//  Created by maksim on 15.01.2022.
//

import SwiftUI

@main
struct TownNewsApp: App {
    private var articleId: Int?
    @ObservedObject private var onboardingViewModel = OnboardingViewModel()
    init() {
        let initTask = SharedViewModel.initApp()
        if let task = initTask {
            let arg = task.task.split(separator: "/")
            if arg.count == 2 {
                if arg[0] == "article" {
                    articleId = Int(arg[1])
                }
            }
        }
    }
    var body: some Scene {
        WindowGroup {
            if onboardingViewModel.isDoneOnboarding {
                AppTabView(articleId: articleId)
            } else {
                OnboardingView(onboardingViewModel: onboardingViewModel)
            }
        }
    }
}
