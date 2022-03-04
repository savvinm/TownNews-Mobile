//
//  Extensions.swift
//  TownNews
//
//  Created by maksim on 26.01.2022.
//

import Foundation
import UIKit

extension UINavigationController{
    open override func viewDidLoad() {
        super.viewDidLoad()
        let attr = [NSAttributedString.Key.font: UIFont.systemFont(ofSize:30)]
        UINavigationBar.appearance().largeTitleTextAttributes = attr
        
    }
}
