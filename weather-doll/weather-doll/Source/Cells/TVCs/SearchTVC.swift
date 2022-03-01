//
//  SearchTVC.swift
//  weather-doll
//
//  Created by 박익범 on 2022/02/28.
//

import UIKit
import SnapKit
import Then

class SearchTVC: UITableViewCell {
    static let identifier: String = "SearchTVC"
    
    var selectButtonCompletion: ((String) -> String)?
    
    private let locationLabel = UILabel().then{
        $0.font = UIFont.gmarketSansMediumFont(ofSize: 24)
        $0.textColor = UIColor.black
        $0.text = ""
    }
    private let selectButton = UIButton().then{
        $0.backgroundColor = UIColor.selectThemeColor
        $0.titleLabel?.textColor = UIColor.white
        $0.titleLabel?.font = UIFont.gmarketSansBoldFont(ofSize: 14)
        $0.setTitle("선택", for: .normal)
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
    }
    
    func setData(city: String){
        locationLabel.text = city
    }
    
    func setLayout(){
        self.contentView.addSubviews([locationLabel, selectButton])
        
        locationLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(0)
            $0.height.equalTo(24)
            $0.width.equalTo(230)
        }
        
        selectButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(0)
            $0.height.equalTo(30)
            $0.width.equalTo(45)
        }
        
        setButtonTarget()
    }
    
    private func setButtonTarget(){
        selectButton.addTarget(self, action: #selector(selectButtonClicked(_:)), for: .touchUpInside)
    }
    
    @objc func selectButtonClicked(_ sender: UIButton) {
        guard let completion = selectButtonCompletion else { return }
        completion(self.locationLabel.text ?? "")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
}
