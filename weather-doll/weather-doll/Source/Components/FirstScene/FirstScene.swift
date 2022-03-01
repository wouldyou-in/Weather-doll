//
//  FirstScene.swift
//  weather-doll
//
//  Created by 박익범 on 2022/02/28.
//

import UIKit
import SnapKit
import Then

class FirstScene: UIView {
    
    private let locationInfoView = UIView().then{
        $0.backgroundColor = .none
        $0.layer.borderColor = UIColor.white.cgColor
        $0.layer.borderWidth = 3
    }
    private let locationInfoLabel = UILabel().then{
        $0.font = UIFont.gmarketSansMediumFont(ofSize: 18)
        $0.textColor = UIColor.white
        $0.text = "이곳을 눌러 위치를\n설정할 수 있어요"
        $0.numberOfLines = 2
    }
    private let notificationView = UIView().then{
        $0.backgroundColor = .none
        $0.layer.borderColor = UIColor.white.cgColor
        $0.layer.borderWidth = 3
    }
    private let notificationLabel = UILabel().then{
        $0.font = UIFont.gmarketSansMediumFont(ofSize: 18)
        $0.textColor = UIColor.white
        $0.text = "이곳을 눌러 알림을\n키고 끌 수 있어요"
        $0.numberOfLines = 2
    }
    
    func setLayout(locView: UIView, notiButton: UIButton) {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        addSubviews([locationInfoView, locationInfoLabel, notificationView, notificationLabel])
        
        locationInfoView.snp.makeConstraints{
            $0.top.equalTo(locView.snp.top).offset(-5)
            $0.leading.equalTo(locView.snp.leading).offset(-5)
            $0.trailing.equalTo(locView.snp.trailing).offset(5)
            $0.bottom.equalTo(locView.snp.bottom).offset(10)
        }
        locationInfoLabel.snp.makeConstraints{
            $0.top.equalTo(locationInfoView.snp.bottom).offset(5)
            $0.leading.equalTo(locationInfoView.snp.leading).offset(0)
            $0.trailing.equalTo(locationInfoView.snp.trailing).offset(0)
            $0.height.equalTo(40)
        }
        notificationView.snp.makeConstraints{
            $0.top.equalTo(notiButton.snp.top).offset(0)
            $0.leading.equalTo(notiButton.snp.leading).offset(0)
            $0.trailing.equalTo(notiButton.snp.trailing).offset(0)
            $0.bottom.equalTo(notiButton.snp.bottom).offset(0)
        }
        notificationLabel.snp.makeConstraints{
            $0.top.equalTo(notificationView.snp.bottom).offset(5)
            $0.trailing.equalTo(notificationView.snp.trailing).offset(0)
            $0.height.equalTo(40)
            $0.width.equalTo(150)
        }
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("Error")
    }
    
    init() {
        super.init(frame: .zero)
    }
}
