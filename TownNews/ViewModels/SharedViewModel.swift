//
//  SharedViewModel.swift
//  TownNews
//
//  Created by Maksim Savvin on 05.03.2022.
//

import Foundation
import UIKit
class SharedViewModel{
    
    func sendArticleIdForFavorite(_ id: Int){
        let url = URL(string: "https://townnews.site/addfavorite/" + String(id) + "/" + String(UIDevice.current.identifierForVendor!.uuidString))
        let task = URLSession.shared.dataTask(with: url!)
        task.resume()
    }
    
    func sendDeleteFor(_ missing: Missing){
        let url = URL(string: "https://townnews.site/deletemissing/" + String(missing.id) + "/" + String(UIDevice.current.identifierForVendor!.uuidString))
        let task = URLSession.shared.dataTask(with: url!)
        task.resume()
    }
    
    static func getFullURLToImage(url: String) -> URL{
        URL(string: "https://townnews.site/getimage/" + url)!
    }
    
}
