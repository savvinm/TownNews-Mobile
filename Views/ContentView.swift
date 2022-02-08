//
//  ContentView.swift
//  TownNews
//
//  Created by maksim on 16.01.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MainPageView().tabItem(){
                Image(systemName: "house.fill")
            }
            FindPeopleView().tabItem(){
                Image(systemName: "person.fill.questionmark")
            }
            PromoView().tabItem(){
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
