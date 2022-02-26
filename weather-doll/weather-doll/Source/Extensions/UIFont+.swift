//
//  UIFont+.swift
//  weather-doll
//
//  Created by 박익범 on 2022/02/26.
//

import UIKit

struct AppFontName {
    static let bold = "GmarketSansBold"
    static let light = "GmarketSansLight"
    static let medium = "GmarketSansMedium"
}

extension UIFont {
    @objc class func gmarketSansBoldFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.bold, size: size)!
    }
    @objc class func gmarketSansLightFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.light, size: size)!
    }
    @objc class func gmarketSansMediumFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.medium, size: size)!
    }
}
