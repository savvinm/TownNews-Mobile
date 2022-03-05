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
            ScrollView{
                LazyVStack{
                    ForEach(mvm.missings){ missing in
                        NavigationLink{
                            MissingView(missing: missing, title: nil)
                        } label: {
                            VStack{
                                    HStack{
                                        Text(missing.name + ",")
                                        Text(missing.age)
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
                mvm.fetchMissings()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Объявления о пропаже")
            .navigationBarItems(trailing: Button(action: {}, label: {
                NavigationLink(destination: AdMissingView()){
                    Image(systemName: "plus.circle.fill")
                }
            }))
        }
    }
}

struct FindPeopleView_Previews: PreviewProvider {
    static var previews: some View {
        let mvm = MissingsListViewModel()
        FindPeopleView(mvm: mvm)
.previewInterfaceOrientation(.portrait)
    }
}
