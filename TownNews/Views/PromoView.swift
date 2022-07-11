//
//  PromoView.swift
//  TownNews
//
//  Created by maksim on 17.01.2022.
//

import SwiftUI

struct PromoView: View {
    @ObservedObject var pvm: PromoViewModel
    @State var id = 0
    var body: some View {
        NavigationView{
            VStack{
                if(!pvm.promos.isEmpty){
                    promoScrollView
                }
                else{
                    emptyMessage
                    }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Предложения от партнеров")
            .onAppear(){
                id = 0
                pvm.fetchPromos()
            }
        }
    }
    
    private var promoScrollView: some View{
        List{
            ForEach(pvm.promos){promo in
                PromoPreview(promo: promo, curentId: id)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                    .listRowSeparator(.hidden)
                    .onTapGesture {
                        if(id != promo.id){
                            UIPasteboard.general.string = promo.promocode
                            id = promo.id
                        }
                    }
            }
        }
        .refreshable {
            id = 0
            pvm.fetchPromos()
        }
    }
    
    private var emptyMessage: some View{
        VStack{
            Spacer()
            Text("На данный момент нет активных предложений").multilineTextAlignment(.center)
            Spacer()
        }
        .padding()
        .foregroundColor(.secondary)
    }
}

private struct PromoPreview: View{
    let promo: Promo
    let curentId: Int
    var body: some View{
        promoBody
    }
    
    private var promoBody: some View{
        VStack{
            Spacer()
            Text(promo.title).multilineTextAlignment(.center)
            Spacer()
            promoImage
            Spacer()
            promocodeField
        }
        .frame(height: UIScreen.main.bounds.height * 0.4)
        .background(Color(.systemGray5))
        .cornerRadius(10)
    }
    
    
    private var promocodeField: some View{
        ZStack{
            HStack{
                Text(promo.promocode)
                if(curentId == promo.id){
                    Image(systemName: "doc.on.doc.fill")
                }
                else{
                    Image(systemName: "doc.on.doc")
                }
            }
            Rectangle()
            .frame(height: 40)
            .background(Color.secondary)
            .opacity(0.1)
        }
    }
    
    private var promoImage: some View{
        AsyncImage(url: SharedViewModel.getFullURLToImage(url: promo.imageUrl)){ image in
            image
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
        } placeholder: {
            ProgressView()
        }
        .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.2)
    }
}


struct PromoView_Previews: PreviewProvider {
    static var previews: some View {
        let pvm = PromoViewModel()
        PromoView(pvm:pvm)
    }
}
