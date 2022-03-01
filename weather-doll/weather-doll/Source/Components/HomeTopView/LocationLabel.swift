//
//  TopBackgroundView.swift
//  weather-doll
//
//  Created by 박익범 on 2022/02/26.
//

import UIKit
import SnapKit
import Then

enum locationType{
    case noSelected
    case selected
}

class LocationLabel: UIView {
    private let locationImageView = UIImageView().then{
        $0.image = UIImage(named: "Location")
    }
    //지역 선택 했을시
    var selectedLabel = UILabel().then{
        $0.text = "지역을 선택해주세요."
        $0.font = UIFont.gmarketSansBoldFont(ofSize: 24)
        $0.textColor = UIColor.white
    }
    lazy var selectedLabelDescription = UILabel().then{
        $0.text = ""
        $0.font = UIFont.gmarketSansLightFont(ofSize: 24)
        $0.textColor = UIColor.white
    }
    private var underlineView = UIView().then{
        $0.backgroundColor = UIColor.white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    init(description: String){
        super.init(frame: .zero)
        self.addSubviews([locationImageView, selectedLabel, selectedLabelDescription, underlineView])
        selectedLabelDescription.text = description
        defaultLayout()
       
    }
    
    func defaultLayout() {
        self.backgroundColor = .none
        locationImageView.snp.makeConstraints{
            $0.top.bottom.leading.equalToSuperview().offset(0)
            $0.width.height.equalTo(24)
        }
        selectedLabel.snp.makeConstraints{
            $0.leading.equalTo(locationImageView.snp.trailing).offset(0)
            $0.top.bottom.equalToSuperview().offset(0)
            $0.height.equalTo(25)
        }
        selectedLabelDescription.snp.makeConstraints{
            $0.leading.equalTo(selectedLabel.snp.trailing).offset(0)
            $0.top.bottom.equalToSuperview().offset(0)
            $0.height.equalTo(25)
        }
        underlineView.snp.makeConstraints{
            $0.top.equalTo(selectedLabel.snp.bottom).offset(3)
            $0.leading.equalTo(selectedLabel.snp.leading).offset(0)
            $0.trailing.equalTo(selectedLabel.snp.trailing).offset(0)
            $0.height.equalTo(2)
        }
    }
    
}
