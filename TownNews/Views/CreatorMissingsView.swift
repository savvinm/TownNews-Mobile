//
//  UserMissingView.swift
//  TownNews
//
//  Created by maksim on 26.01.2022.
//

import SwiftUI

struct CreatorMissingsView: View {
    @ObservedObject var mvm: MissingViewModel
    var body: some View {
        if(mvm.missings.isEmpty){
            emptyMessage
        }
        missingsScrollView
    }
    
    private var missingsScrollView: some View{
        ScrollView{
            LazyVStack{
                ForEach(mvm.missings){ MissingPreview(missing: $0, isCreator: true) }
                .padding(.top)
            }
        }
        .onAppear(){ mvm.fetchUserMissings() }
        .navigationBarTitle("Мои объявления")
    }
    
    private var emptyMessage: some View{
        VStack{
            Spacer()
            Text("Не найдено созданных вами объявлений").multilineTextAlignment(.center).foregroundColor(.secondary)
            Spacer()
        }
    }
}

struct UserMissingView_Previews: PreviewProvider {
    static var previews: some View {
        let mvm = MissingViewModel()
        CreatorMissingsView(mvm:mvm)
    }
}
