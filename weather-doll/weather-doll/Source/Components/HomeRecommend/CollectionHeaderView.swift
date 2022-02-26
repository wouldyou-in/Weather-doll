//
//  CollectionHeaderView.swift
//  weather-doll
//
//  Created by 박익범 on 2022/02/26.
//

import UIKit
import SnapKit
import Then

class CollectionHeaderView: UICollectionReusableView {
    
    let recommendThemeArr: [String] = ["전체", "의류", "취미", "활동", "생활"]

    private let titleLabel = UILabel().then{
        $0.font = UIFont.gmarketSansMediumFont(ofSize: 24)
        $0.textColor = UIColor.selectThemeColor
        $0.text = "추천 생활지수"
    }
    private let selectButtonStackView = UIStackView().then{
        $0.axis = .horizontal
        $0.alignment = .leading
        $0.distribution = .fillEqually
        $0.spacing = 5
        $0.layoutMargins = UIEdgeInsets(top: 0 , left: 0 , bottom: 0, right: 0)
        $0.isLayoutMarginsRelativeArrangement = true
    }
    func setLayout(){
        addSubviews([titleLabel, selectButtonStackView])
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(21)
            $0.height.equalTo(24)
        }
        selectButtonStackView.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(21)
            $0.height.equalTo(24)
            $0.width.equalTo(205)
        }
        setButton()
    }
    
    func setButton(){
        recommendThemeArr.forEach{
            let button = ThemeButton()
            selectButtonStackView.addArrangedSubview(button)
            button.snp.makeConstraints{
                $0.width.equalTo(36)
                $0.height.equalTo(24)
            }
            button.titleLabel.text = $0
            print(button)
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
        print(reuseIdentifier)

    }
}
