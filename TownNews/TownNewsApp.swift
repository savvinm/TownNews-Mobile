//
//  TownNewsApp.swift
//  TownNews
//
//  Created by maksim on 15.01.2022.
//

import SwiftUI

@main
struct TownNewsApp: App {
    var articleId: Int?
    init(){
        let initTask = SharedViewModel.initApp()
        if let task = initTask{
            let arg = task.task.split(separator: "/")
            if arg.count == 2{
                if arg[0] == "article"{
                    articleId = Int(arg[1])
                }
            }
        }
    }
    var body: some Scene {
        WindowGroup {
            AppTabView(articleId: articleId)
        }
    }
}
