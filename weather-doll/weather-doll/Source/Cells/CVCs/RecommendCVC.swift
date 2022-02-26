//
//  RecommendCVC.swift
//  weather-doll
//
//  Created by 박익범 on 2022/02/27.
//

import UIKit
import SnapKit
import Then

class RecommendCVC: UICollectionViewCell {
    
    static let identifier: String = "RecommendCVC"
    
    let titleLabel = UILabel().then{
        $0.font = UIFont.gmarketSansMediumFont(ofSize: 18)
        $0.textColor = UIColor.mainThemeColor
        $0.textAlignment = .center
    }
    
    let indexValueLabel = UILabel().then{
        $0.font = UIFont.gmarketSansBoldFont(ofSize: 72)
        $0.textColor = UIColor.indexTextColor
        $0.textAlignment = .center
    }
    
    let descriptionLabel = UILabel().then{
        $0.font = UIFont.gmarketSansMediumFont(ofSize: 13)
        $0.textColor = UIColor.textColor
        $0.numberOfLines = 2
        $0.textAlignment = .left
    }
    
    func setLayout(){
        addSubviews([titleLabel, indexValueLabel, descriptionLabel])
        
        self.clipsToBounds = true
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.mainThemeColor.cgColor
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(12)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
        }
        indexValueLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(130)
        }
        descriptionLabel.snp.makeConstraints{
            $0.top.equalTo(indexValueLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(132)
        }
    }
    
    
    func setData(indexName: String, indexValue: String, description: String){
        titleLabel.text = indexName
        indexValueLabel.text = indexValue
        descriptionLabel.text = description
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }

}
