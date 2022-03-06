//
//  CreatorMissing.swift
//  TownNews
//
//  Created by maksim on 26.01.2022.
//

import SwiftUI

struct CreatorMissingView: View {
    let missing: Missing
    @State private var shAlert = false
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    var body: some View {
        ScrollView{
            if(missing.status == "accepted"){
                MissingView(missing: missing, title: "Опубликовано")
            }
            else{
                MissingView(missing: missing, title: "Ожидает проверки")
            }
        }
        .navigationBarItems(trailing: Button(action: {
            shAlert = true
        }, label: {
            Image(systemName: "trash.fill")
        }))
        .alert("Удалить данное объявление?", isPresented: $shAlert){
            Button("Нет", role: .cancel, action: {})
            Button("Да", role: .destructive, action: {
                let api = SharedViewModel()
                api.sendDeleteFor(missing)
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

