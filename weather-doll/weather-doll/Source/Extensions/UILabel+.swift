//
//  UILabel+.swift
//  weather-doll
//
//  Created by 박익범 on 2022/02/26.
//

import UIKit

extension UILabel {
    func setBoldAttributeText(targetString: [String], font: UIFont) {
        var rangeArr: [NSRange] = []
        var index = 0
        let text = self.text ?? ""
        var range = NSRange(location: 0, length: text.count)

        let attributeString = NSMutableAttributedString(string: text)
        
        while (range.location != NSNotFound) {
            if (range.length == 0) {
                break
            }
            range = (attributeString.string as NSString).range(of: targetString[index], range: range)
            rangeArr.append(range)
            if (range.location != NSNotFound) {
                index += 1
                range = NSRange(location: range.location + range.length, length: text.count - (range.location + range.length))
            }
        }
        rangeArr.forEach { (range) in
            attributeString.addAttribute(.font, value: font, range: range)
        }
        self.attributedText = attributeString
    }
    
    func setBoldAttributeText(targetStr: String, font: UIFont) {
        let text = self.text ?? ""
        var range = NSRange(location: 0, length: text.count)
        let attributeString = NSMutableAttributedString(string: text)
        range = (attributeString.string as NSString).range(of: targetStr, range: range)
        attributeString.addAttribute(.font, value: font, range: range)
        
        self.attributedText = attributeString
    }
}
