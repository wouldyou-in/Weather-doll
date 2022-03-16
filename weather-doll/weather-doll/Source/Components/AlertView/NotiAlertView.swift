//
//  NotiAlertView.swift
//  weather-doll
//
//  Created by 박익범 on 2022/03/15.
//

import Foundation
import UIKit
import SnapKit
import Then

class NotiAlertView: UIView {
    
    var dateCompletion: ((String) -> String)?
    
    private let timeLabel = UILabel().then{
        $0.font = UIFont.gmarketSansMediumFont(ofSize: 17)
        $0.text = "알림 받을 시간"
    }
    private let timepicker = UIDatePicker().then{
        $0.datePickerMode = .time
        $0.preferredDatePickerStyle = .inline
    }
    private let descriptionLabel = UILabel().then{
        $0.numberOfLines = 2
        $0.textColor = UIColor.mainThemeColor
        $0.text = "날수가 지정한 시간에 오늘의 날씨와 날씨에 따른주요한 지수를 알려드려요."
    }
    private let cancelButton = UIButton().then{
        $0.setTitle("취소", for: .normal)
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
        $0.layer.borderColor = UIColor.mainThemeColor.cgColor
        $0.backgroundColor = UIColor.white
        $0.layer.borderWidth = 1
        $0.titleLabel?.font = UIFont.gmarketSansMediumFont(ofSize: 18)
        $0.setTitleColor(UIColor.mainThemeColor, for: .normal)
    }
    private let acceptButton = UIButton().then{
        $0.setTitle("적용", for: .normal)
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
        $0.backgroundColor = UIColor.mainThemeColor
        $0.titleLabel?.font = UIFont.gmarketSansBoldFont(ofSize: 18)
        $0.setTitleColor(UIColor.white, for: .normal)
    }
    
    
    private func setLayout() {
        addSubviews([timeLabel, timepicker, descriptionLabel, cancelButton, acceptButton])
        
        self.backgroundColor = UIColor.white
        self.clipsToBounds = true
        self.layer.cornerRadius = 20
        
        timeLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(75)
            $0.leading.equalToSuperview().offset(32)
            $0.height.equalTo(22)
        }
        timepicker.snp.makeConstraints{
            $0.centerY.equalTo(timeLabel)
            $0.trailing.equalToSuperview().offset(-32)
        }
        descriptionLabel.snp.makeConstraints{
            $0.top.equalTo(timeLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(32)
            $0.trailing.equalToSuperview().offset(-32)
            $0.height.equalTo(44)
        }
        cancelButton.snp.makeConstraints{
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(40)
            $0.trailing.equalToSuperview().offset(-32)
            $0.leading.equalToSuperview().offset(32)
            $0.height.equalTo(40)
        }
        acceptButton.snp.makeConstraints{
            $0.top.equalTo(cancelButton.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(32)
            $0.trailing.equalToSuperview().offset(-32)
            $0.height.equalTo(40)
        }
        
        cancelButton.addTarget(self, action: #selector(cancelButtonClicked(_:)), for: .touchUpInside)
        acceptButton.addTarget(self, action: #selector(acceptButtonClicked(_:)), for: .touchUpInside)
    }
    
    @objc func cancelButtonClicked(_ sender: UIButton) {
        guard let completion = dateCompletion else { return }
        completion("취소")
    }
    @objc func acceptButtonClicked(_ sender: UIButton){
        guard let completion = dateCompletion else { return }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        var date = formatter.string(from: timepicker.date)
        completion(date)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
