//
//  PromoView.swift
//  TownNews
//
//  Created by maksim on 17.01.2022.
//

import SwiftUI

struct PromoView: View {
    @ObservedObject var promosViewModel: PromosViewModel
    @State var id = 0
    var body: some View {
        NavigationView {
            VStack {
                switch promosViewModel.status {
                case .loading:
                    ProgressView()
                case .success:
                    successBlock
                case .error(let error):
                    Text(error.localizedDescription)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Предложения от партнеров")
            .onAppear {
                id = 0
                promosViewModel.fetchPromos()
            }
        }
    }
    
    private var successBlock: some View {
        VStack {
            if !promosViewModel.promos.isEmpty {
                promoScrollView
            } else {
                emptyMessage
            }
        }
    }
    
    private var promoScrollView: some View {
        List {
            ForEach(promosViewModel.promos) { promo in
                PromoPreview(promo: promo, curentId: id)
                    .onTapGesture {
                        if id != promo.id {
                            UIPasteboard.general.string = promo.promocode
                            id = promo.id
                        }
                    }
            }
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            .listRowSeparator(.hidden)
        }
        .refreshable {
            id = 0
            promosViewModel.fetchPromos()
        }
    }
    
    private var emptyMessage: some View {
        InfoMultilineText(value: "На данный момент нет активных предложений")
    }
}

struct PromoView_Previews: PreviewProvider {
    static var previews: some View {
        let promosViewModel = PromosViewModel()
        PromoView(promosViewModel: promosViewModel)
    }
}
