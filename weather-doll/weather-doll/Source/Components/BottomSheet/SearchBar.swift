//
//  SearchBar.swift
//  weather-doll
//
//  Created by 박익범 on 2022/02/28.
//

import UIKit
import SnapKit
import Then

class SearchBar: UITextField {
    func setLayout(){
        self.backgroundColor = UIColor.subGrayColor
        self.tintColor = UIColor.black
        self.font = UIFont.gmarketSansMediumFont(ofSize: 24)
        self.textColor = UIColor.searchTextColor
        self.addLeftPadding(9)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    init(){
        super.init(frame: .zero)
        setLayout()
    }
}
