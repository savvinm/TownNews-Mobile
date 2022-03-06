//
//  PromoView.swift
//  TownNews
//
//  Created by maksim on 17.01.2022.
//

import SwiftUI
import MobileCoreServices
struct PromoView: View {
    @ObservedObject var pvm: PromosListViewModel
    @State var id = 0
    var body: some View {
        NavigationView{
            if(!pvm.promos.isEmpty){
                ScrollView{
                    LazyVStack{
                        ForEach(pvm.promos){promo in
                            PromoPreview(promo: promo, curentId: id)
                                .padding(.top)
                                .onTapGesture {
                                    if(id != promo.id){
                                        UIPasteboard.general.string = promo.promocode
                                        id = promo.id
                                    }
                                }
                        }
                    }
                    .onAppear(){
                        id = 0
                        pvm.fetchPromos()
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Предложения от партнеров")
            }
            else{
                VStack{
                    Spacer()
                    Text("На данный момент нет активных предложений").multilineTextAlignment(.center)
                    Spacer()
                }
                .foregroundColor(.secondary)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Предложения от партнеров")
                .onAppear(){
                    id = 0
                    pvm.fetchPromos()
                }
            }
        }
    }
}

private struct PromoPreview: View{
    let promo: Promo
    let curentId: Int
    var body: some View{
        VStack{
            Spacer()
            Text(promo.title).multilineTextAlignment(.center)
            Spacer()
            AsyncImage(url: SharedViewModel.getFullURLToImage(url: promo.imageUrl)){ image in
                image.resizable()
                    .scaledToFit()
                    .cornerRadius(10)
            } placeholder: {
                ProgressView()
            }.frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.2)
            Spacer()
            ZStack{
                HStack{
                    Text(promo.promocode)
                    if(curentId == promo.id){
                        Image(systemName:
                        "doc.on.doc.fill")
                    }
                    else{
                        Image(systemName: "doc.on.doc")
                    }
                }
                HStack{
                    
                }
                .frame(width: UIScreen.main.bounds.width * 0.9, height: 40)
                .cornerRadius(10)
                .background(Color.secondary)
                .opacity(0.1)
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.4)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}


struct PromoView_Previews: PreviewProvider {
    static var previews: some View {
        let pvm = PromosListViewModel()
        PromoView(pvm:pvm)
    }
}
