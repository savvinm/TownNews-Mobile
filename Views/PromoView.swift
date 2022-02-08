//
//  PromoView.swift
//  TownNews
//
//  Created by maksim on 17.01.2022.
//

import SwiftUI
import MobileCoreServices
struct PromoView: View {
    @StateObject var vm = PromosListViewModel()
    @State var id = 0
    var body: some View {
        NavigationView{
            ZStack{
                ScrollView{
                        LazyVStack{
                        ForEach(vm.promos){ promo in
                                VStack{
                                    Spacer()
                                    Text(promo.title).multilineTextAlignment(.center)
                                    Spacer()
                                    let url = URL(string: "https://townnews.site/getimage/" + promo.imageUrl)
                                    AsyncImage(url: url){ image in
                                        image.resizable()
                                            .scaledToFill()
                                            .cornerRadius(10)
                                    } placeholder: {
                                        ProgressView()
                                    }.frame(width: 100, height: 110)
                                    Spacer()
                                    ZStack{
                                        HStack{
                                            Text(promo.promocode)
                                            if(id == promo.id){
                                                Image(systemName:
                                                "doc.on.doc.fill")
                                            }
                                            else{
                                                Image(systemName: "doc.on.doc")
                                            }
                                        }
                                        HStack{
                                            
                                        }
                                        .frame(width: UIScreen.main.bounds.width - 50, height: 40)
                                        .cornerRadius(10)
                                        .background(Color.secondary)
                                        .opacity(0.1)
                                    }
                                }
                                .frame(width: UIScreen.main.bounds.width - 50, height: 220)
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                                .onTapGesture {
                                    if(id != promo.id){
                                        UIPasteboard.general.string = promo.promocode
                                        id = promo.id
                                    }
                                }
                            }
                        .padding()
                        }
                    }
                .onAppear(){
                    id = 0
                    vm.fetchPromos()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Предложения от партнеров")
        }
    }
}

struct PromoView_Previews: PreviewProvider {
    static var previews: some View {
        PromoView()
    }
}
