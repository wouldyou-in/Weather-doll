//
//  WKLabel+.swift
//  watch-doll WatchKit Extension
//
//  Created by 박익범 on 2022/03/03.
//

import Foundation
import WatchKit

extension WKInterfaceLabel {
    func setBoldAttributeText(targetString: [String], font: UIFont, originText: String) {
        var rangeArr: [NSRange] = []
        var index = 0
        let text = originText
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
            print(range)
        }
        self.setAttributedText(attributeString)
//        self.attributedText = attributeString
    }
    
}
