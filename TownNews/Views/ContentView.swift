//
//  ContentView.swift
//  TownNews
//
//  Created by maksim on 16.01.2022.
//

import SwiftUI

struct ContentView: View {
    let avm = ArticlesListViewModel()
    let pvm = PromosListViewModel()
    let mvm = MissingsListViewModel()
    let tvm = TagsListViewModel()
    var body: some View {
        TabView {
            NewsPageView(avm: avm, tvm: tvm).tabItem(){
                Image(systemName: "house.fill")
            }
            FindPeopleView(mvm:mvm).tabItem(){
                Image(systemName: "person.fill.questionmark")
            }
            PromoView(pvm:pvm).tabItem(){
                Image(systemName: "giftcard.fill")
            }
            AccountView().tabItem(){
                Image(systemName: "list.bullet")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
