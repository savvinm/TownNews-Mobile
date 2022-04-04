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
        VStack{
            if(mvm.missings.isEmpty){
                emptyMessage
            } else{
                missingsScrollView
            }
        }
        .navigationTitle("Мои объявления")
        .onAppear(){ mvm.fetchUserMissings() }
    }
    
    private var missingsScrollView: some View{
        List{
            ForEach(mvm.missings){ MissingPreview(missing: $0, isCreator: true) }
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            .listRowSeparator(.hidden)
        }
        .refreshable {
            mvm.fetchUserMissings()
        }
    }
    
    private var emptyMessage: some View{
        VStack{
            Spacer()
            Text("Не найдено созданных вами объявлений").multilineTextAlignment(.center)
            Spacer()
        }
        .padding()
        .foregroundColor(.secondary)
    }
}

struct UserMissingView_Previews: PreviewProvider {
    static var previews: some View {
        let mvm = MissingViewModel()
        CreatorMissingsView(mvm:mvm)
    }
}
