//
//  ThemeButton.swift
//  weather-doll
//
//  Created by 박익범 on 2022/02/27.
//

import UIKit
import SnapKit
import Then

class ThemeButton: UIView{
    let titleLabel = UILabel().then{
        $0.font = UIFont.gmarketSansMediumFont(ofSize: 14)
        $0.textColor = UIColor.selectThemeColor
        $0.textAlignment = .center
    }
    
    func setLayout(){
        addSubview(titleLabel)
        
        self.clipsToBounds = true
        self.layer.cornerRadius = 9
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.mainThemeColor.cgColor
        self.backgroundColor = UIColor.white
        
        titleLabel.snp.makeConstraints{
            $0.centerX.centerY.equalToSuperview()
        }
        
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
