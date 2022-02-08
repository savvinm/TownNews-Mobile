//
//  CreatorMissing.swift
//  TownNews
//
//  Created by maksim on 26.01.2022.
//

import SwiftUI

struct CreatorMissingView: View {
    var missing: Missing
    @State private var shAlert = false
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    var body: some View {
        ScrollView{
            if(missing.status == "accepted"){
                Text("Опубликовано").font(.headline)
            }
            else{
                Text("Ожидает проверки").font(.headline)
            }
            let url = URL(string: "https://townnews.site/getimage/" + missing.imageUrl)
            AsyncImage(url: url){ image in
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
                VStack{
                    HStack{
                        Text("Имя:").font(.body.weight(.bold))
                        Spacer()
                    }
                    HStack{
                        Text(missing.name)
                        Spacer()
                    }
                }
                .padding(.bottom)
                VStack{
                    HStack{
                        Text("Возраст:").font(.body.weight(.bold))
                        Spacer()
                    }
                    HStack{
                        Text(missing.age)
                        Spacer()
                    }
                }
                .padding(.bottom)
                VStack{
                    HStack{
                        Text("Пол:").font(.body.weight(.bold))
                        Spacer()
                    }
                    HStack{
                        Text(missing.sex)
                        Spacer()
                    }
                }
                .padding(.bottom)
                VStack{
                    HStack{
                        Text("Приметы:").font(.body.weight(.bold))
                        Spacer()
                    }
                    HStack{
                        Text(missing.characteristics)
                        Spacer()
                    }
                }
                .padding(.bottom)
                VStack{
                    HStack{
                        Text("Особые приметы:").font(.body.weight(.bold))
                        Spacer()
                    }
                    HStack{
                        Text(missing.specCharacteristics)
                        Spacer()
                    }
                }
                .padding(.bottom)
                VStack{
                    HStack{
                        Text("Последнее местонахождение:").font(.body.weight(.bold))
                        Spacer()
                    }
                    HStack{
                        Text(missing.lastLocation)
                        Spacer()
                    }
                }
                .padding(.bottom)
                VStack{
                    HStack{
                        Text("Был одет:").font(.body.weight(.bold))
                        Spacer()
                    }
                    HStack{
                        Text(missing.clothes)
                        Spacer()
                    }
                }
                .padding(.bottom)
                VStack{
                    HStack{
                        Text("Телефон для связи:").font(.body.weight(.bold))
                        Spacer()
                    }
                    HStack{
                        Text(missing.telephone)
                        Spacer()
                    }
                }
                .padding(.bottom)
            }
            .font(.callout)
        }
        .navigationBarItems(trailing: Button(action: {
            shAlert = true
        }, label: {
            Image(systemName: "trash.fill")
        }))
        .alert("Удалить данное объявление?", isPresented: $shAlert){
            Button("Нет", role: .cancel, action: {})
            Button("Да", role: .destructive, action: {
                let url = URL(string: "https://townnews.site/deletemissing/" + String(missing.id) + "/" + String(UIDevice.current.identifierForVendor!.uuidString))
                let task = URLSession.shared.dataTask(with: url!)
                task.resume()
                self.presentationMode.wrappedValue.dismiss()
            })
        }
        //.padding(.top, -20)
        .padding([.leading, .bottom, .trailing])
    }
}

