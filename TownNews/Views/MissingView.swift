//
//  MissingView.swift
//  TownNews
//
//  Created by maksim on 25.01.2022.
//

import SwiftUI

struct MissingView: View {
    let missing: Missing
    let title: String?
    var body: some View {
        ScrollView{
            Text(title ?? "Пропал человек").font(.headline)
            AsyncImage(url: SharedViewModel.getFullURLToImage(url: missing.imageUrl)){ image in
                image.resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.height/2)
            } placeholder: {
                ProgressView().frame(width: 100, height: 100)
            }
            /*Section(header: Text("")){

            }
            Section(header: Text("Приметы")){
                Text(missing.characteristics)
            }
            Section(header: Text("Особые приметы")){
                Text(missing.specCharacteristics)
            }
            Section(header: Text("Последняя информация о местонахождении")){
                Text(missing.lastLocation)
            }
            Section(header: Text("Телефон для связи")){
                Text(missing.telephone)
            }
        }
    }*/

            VStack{

                MissingSection(label: "Имя", value: missing.name)
                
                MissingSection(label: "Возраст", value: missing.age)

                MissingSection(label: "Пол", value: missing.sex)

                MissingSection(label: "Приметы", value: missing.characteristics)
                
                MissingSection(label: "Особые приметы", value: missing.specCharacteristics)
                
                MissingSection(label: "Последнее местонахождение", value: missing.lastLocation)
                
                MissingSection(label: "Был одет", value: missing.clothes)

                MissingSection(label: "Телефон для связи", value: missing.telephone)

            }
            .font(.callout)
        }
        .padding([.leading, .bottom, .trailing])
    }
}

private struct MissingSection: View{
    let label: String
    let value: String
    var body: some View{
        VStack{
            HStack{
                Text(label + ":").font(.body.weight(.bold))
                Spacer()
            }
            HStack{
                Text(value)
                Spacer()
            }
        }
        .padding(.bottom)
    }
}
