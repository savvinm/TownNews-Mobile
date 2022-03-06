//
//  UserMissingView.swift
//  TownNews
//
//  Created by maksim on 26.01.2022.
//

import SwiftUI

struct CreatorMissingsView: View {
    @ObservedObject var mvm: MissingsListViewModel
    var body: some View {
        if(mvm.missings.isEmpty){
            VStack{
                Spacer()
                Text("Не найдено созданных вами объявлений").multilineTextAlignment(.center).foregroundColor(.secondary)
                Spacer()
            }
        }
        ScrollView{
            LazyVStack{
                ForEach(mvm.missings){ MissingPreview(missing: $0, isCreator: true) }
                .padding(.top)
            }
        }
        .onAppear(){ mvm.fetchUserMissings() }
        .navigationBarTitle("Мои объявления")
    }
}

struct UserMissingView_Previews: PreviewProvider {
    static var previews: some View {
        let mvm = MissingsListViewModel()
        CreatorMissingsView(mvm:mvm)
    }
}
