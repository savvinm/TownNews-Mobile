//
//  FindPeopleView.swift
//  TownNews
//
//  Created by maksim on 16.01.2022.
//

import Foundation
import SwiftUI
import AVFoundation

struct FindPeopleView: View {
    @ObservedObject var mvm: MissingsListViewModel
    var body: some View {
        NavigationView{
            if(!mvm.missings.isEmpty){
                ScrollView{
                    LazyVStack{
                        ForEach(mvm.missings){ MissingPreview(missing: $0, isCreator: false) }
                        .padding(.top)
                    }
                }
                .onAppear(){ mvm.fetchMissings() }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Объявления о пропаже")
                .navigationBarItems(trailing: Button(action: {}, label: {
                    NavigationLink(destination: AdMissingView()){
                        Image(systemName: "plus.circle.fill")
                    }
                }))
            }
            else{
                VStack{
                    Spacer()
                    Text("На данный момент нет активных объявлений о пропаже людей").multilineTextAlignment(.center)
                    Spacer()
                }
                .foregroundColor(.secondary)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Объявления о пропаже")
                .navigationBarItems(trailing: Button(action: {}, label: {
                    NavigationLink(destination: AdMissingView()){
                        Image(systemName: "plus.circle.fill")
                    }
                }))
                .onAppear(){ mvm.fetchMissings() }
            }
        }
    }
}

struct FindPeopleView_Previews: PreviewProvider {
    static var previews: some View {
        let mvm = MissingsListViewModel()
        FindPeopleView(mvm: mvm)
    }
}
