//
//  UIStackView+.swift
//  weather-doll
//
//  Created by 박익범 on 2022/03/01.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach{ addArrangedSubview($0) }
    }
}
