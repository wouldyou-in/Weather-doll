//
//  CollectionHeaderView.swift
//  weather-doll
//
//  Created by 박익범 on 2022/02/26.
//

import UIKit
import SnapKit
import Then

class buttonNameAction: UITapGestureRecognizer {
    var text: String = ""
    var button: ThemeButton?
}

class CollectionHeaderView: UICollectionReusableView {
    
    let recommendThemeArr: [String] = ["전체", "의류", "음식", "활동", "생활"]

    var recommendButtonCompletion: ((String) -> String)?
    
    let allButton = ThemeButton()
    let clothesButton = ThemeButton()
    let hobbyButton = ThemeButton()
    let exersiceButton = ThemeButton()
    let lifeButton = ThemeButton()
    
    var buttonArr: [ThemeButton] = []

    
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
        var index = 0
        allButton.titleLabel.textColor = UIColor.white
        allButton.backgroundColor = UIColor.selectThemeColor
        buttonArr = [allButton, clothesButton, hobbyButton, exersiceButton, lifeButton]
        selectButtonStackView.addArrangedSubviews(buttonArr)
        buttonArr.forEach {
            let gesture = buttonNameAction(target: self, action: #selector(recommendButtonClicked(gesture:)))
            $0.addGestureRecognizer(gesture)
            $0.isUserInteractionEnabled = true
            gesture.button = $0
            gesture.text = recommendThemeArr[index]
            $0.titleLabel.text = recommendThemeArr[index]
            $0.snp.makeConstraints{
                $0.width.equalTo(36)
                $0.height.equalTo(24)
            }
            index += 1
        }
    }
    
    func clearColor(){
        buttonArr.forEach{
            $0.backgroundColor = UIColor.white
            $0.titleLabel.textColor = UIColor.selectThemeColor
        }
    }
    
    @objc func recommendButtonClicked(gesture: buttonNameAction) {
        print("clicked")
        clearColor()
        gesture.button?.titleLabel.textColor = UIColor.white
        gesture.button?.backgroundColor = UIColor.selectThemeColor
        guard let completion = recommendButtonCompletion else {return}
        completion(gesture.text)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    init(){
        super.init(frame: .zero)
        setLayout()
    }
}
