//
//  Extensions.swift
//  TownNews
//
//  Created by maksim on 26.01.2022.
//

import Foundation
import UIKit

enum TabIdentifier: Hashable{
    case news, find, promo, account
}
enum PageIdentifier: Hashable{
    case article(id: Int)
    case missing(id: Int)
}

extension URL{
    var detailPage: PageIdentifier?{
        guard let tab = tabIdentifier, pathComponents.count > 1, let id = Int(pathComponents[1]) else { return nil }
        switch tabIdentifier{
        case .news: return .article(id: id)
        case .find: return .missing(id: id)
        default: return nil
        }
    }
}

extension URL{
    var isDeepLink: Bool{
        return scheme == "townnews.app"
    }
    var tabIdentifier: TabIdentifier?{
        guard isDeepLink else { return nil }
        switch host {
        case "news": return .news
        case "find": return .find
        case "promo": return .promo
        case "account": return .account
        default: return nil
        }
    }
}

extension UINavigationController{
    open override func viewDidLoad() {
        super.viewDidLoad()
        let attr = [NSAttributedString.Key.font: UIFont.systemFont(ofSize:30)]
        UINavigationBar.appearance().largeTitleTextAttributes = attr
        
    }
}

extension UIImage {
    /// Fix image orientaton to protrait up
    func fixedOrientation() -> UIImage? {
        guard imageOrientation != UIImage.Orientation.up else {
            // This is default orientation, don't need to do anything
            return self.copy() as? UIImage
        }

        guard let cgImage = self.cgImage else {
            // CGImage is not available
            return nil
        }

        guard let colorSpace = cgImage.colorSpace, let ctx = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else {
            return nil // Not able to create CGContext
        }

        var transform: CGAffineTransform = CGAffineTransform.identity

        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat.pi)
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: CGFloat.pi / 2.0)
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: CGFloat.pi / -2.0)
        case .up, .upMirrored:
            break
        @unknown default:
            fatalError("Missing...")
            break
        }

        // Flip image one more time if needed to, this is to prevent flipped image
        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .up, .down, .left, .right:
            break
        @unknown default:
            fatalError("Missing...")
            break
        }

        ctx.concatenate(transform)

        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
        default:
            ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            break
        }

        guard let newCGImage = ctx.makeImage() else { return nil }
        return UIImage.init(cgImage: newCGImage, scale: 1, orientation: .up)
    }
}
