//
//  MissingsListView.swift
//  TownNews
//
//  Created by maksim on 16.01.2022.
//

import Foundation
import SwiftUI
import AVFoundation

struct MissingsListView: View {
    @ObservedObject var mvm: MissingViewModel
    var body: some View {
        NavigationView{
            VStack{
                if(!mvm.missings.isEmpty){
                    missingsScrollView
                }
                else{
                    emptyMessage
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Объявления о пропаже")
            .navigationBarItems(trailing: addButton)
            .onAppear(){ mvm.fetchMissings() }
        }
    }
    
    
    private var emptyMessage: some View{
        VStack{
            Spacer()
            Text("На данный момент нет активных объявлений о пропаже людей").multilineTextAlignment(.center)
            Spacer()
        }
        .padding()
        .foregroundColor(.secondary)
    }
    
    private var missingsScrollView: some View{
        List{
            ForEach(mvm.missings){ MissingPreview(missing: $0) }
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                .listRowSeparator(.hidden)
        }
        .refreshable {
            mvm.fetchMissings()
        }
    }
    
    private var addButton: some View{
        Button(action: {}, label: {
            NavigationLink(destination: AdMissingView()){
                Image(systemName: "plus.circle.fill")
            }
        })
    }
}

struct FindPeopleView_Previews: PreviewProvider {
    static var previews: some View {
        let mvm = MissingViewModel()
        MissingsListView(mvm: mvm)
    }
}
