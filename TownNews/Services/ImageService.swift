//
//  ImageService.swift
//  TownNews
//
//  Created by Maksim Savvin on 18.09.2022.
//

import SwiftUI

final class ImageService {
    func resizeImage(_ image: UIImage) -> UIImage? {
        var actualHeight = Float(image.size.height)
        var actualWidth = Float(image.size.width)

        let maxHeight: Float = 720.0
        let maxWidth: Float = 720.0

        var imgRatio = actualWidth/actualHeight
        let maxRatio = maxWidth/maxHeight

        if (actualHeight > maxHeight) || (actualWidth > maxWidth) {
            if imgRatio < maxRatio {
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            } else if imgRatio > maxRatio {
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            } else {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }

        let rect = CGRect(x: 0.0, y: 0.0, width: CGFloat(actualWidth), height: CGFloat(actualHeight))
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in: rect)
        guard
            let img = UIGraphicsGetImageFromCurrentImageContext(),
            let imageData = img.jpegData(compressionQuality: 1.0)
        else {
            UIGraphicsEndImageContext()
            return nil
        }
        UIGraphicsEndImageContext()
        return UIImage(data: imageData)
    }
    
     func compressImage(_ image: UIImage) -> String? {
         let compression = 0.4
         let imageData = image.jpegData(compressionQuality: compression)
         return imageData?.base64EncodedString(options: .lineLength64Characters)
     }
}
