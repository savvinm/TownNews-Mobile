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
    @ObservedObject var mvm: MissingViewModel
    var body: some View {
        NavigationView{
            if(!mvm.missings.isEmpty){
                missingsScrollView
            }
            else{
                emptyMessage
            }
        }
        .onAppear(){ mvm.fetchMissings() }
    }
    
    
    private var emptyMessage: some View{
        VStack{
            Spacer()
            Text("На данный момент нет активных объявлений о пропаже людей").multilineTextAlignment(.center)
            Spacer()
        }
        .padding()
        .foregroundColor(.secondary)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Объявления о пропаже")
        .navigationBarItems(trailing: addButton)
    }
    
    private var missingsScrollView: some View{
        ScrollView{
            LazyVStack{
                ForEach(mvm.missings){ MissingPreview(missing: $0) }
                .padding(.top)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Объявления о пропаже")
        .navigationBarItems(trailing: addButton)
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
        FindPeopleView(mvm: mvm)
    }
}
