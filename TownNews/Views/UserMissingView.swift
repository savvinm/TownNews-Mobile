//
//  UserMissingView.swift
//  TownNews
//
//  Created by maksim on 26.01.2022.
//

import SwiftUI

struct UserMissingView: View {
    @ObservedObject var mvm: MissingsListViewModel
    var body: some View {
        if(mvm.missings.count == 0){
            VStack{
                Spacer()
                Text("Не найдено созданных вами объявлений").multilineTextAlignment(.center).foregroundColor(.secondary)
                Spacer()
            }
        }
        ScrollView{
            LazyVStack{
                ForEach(mvm.missings){ missing in
                    NavigationLink{
                        CreatorMissingView(missing: missing)
                    } label: {
                        VStack{
                                //Spacer()
                                HStack{
                                    Text(missing.name + ",")//.font(.footnote)
                                    Text(missing.age)//.font(.footnote)
                                }
                                Spacer()
                                let url = URL(string: "https://townnews.site/getimage/" + missing.imageUrl)
                                AsyncImage(url: url){ image in
                                    image.resizable()
                                        .scaledToFill()
                                        .cornerRadius(20)
                                        .frame(width: UIScreen.main.bounds.width/2.2, height: UIScreen.main.bounds.width/2.2)
                                        .clipped()
                                        .padding(.bottom, 0.0)
                                } placeholder: {
                                    ProgressView()
                                }.frame(width: 100, height: 110)
                                Spacer()
                        }.padding().frame(width: UIScreen.main.bounds.width - 50, height: 250).background(Color(.systemGray6))
                            .cornerRadius(10)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding()
                }
            }
        }
        .onAppear() {
            mvm.fetchUserMissings()
        }
    }
}

struct UserMissingView_Previews: PreviewProvider {
    static var previews: some View {
        let mvm = MissingsListViewModel()
        UserMissingView(mvm:mvm)
    }
}
