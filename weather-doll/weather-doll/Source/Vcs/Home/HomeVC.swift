//
//  HomeVC.swift
//  weather-doll
//
//  Created by 박익범 on 2022/02/26.
//

import UIKit
import SnapKit
import Then

class HomeVC: UIViewController {
    //topView
    private var locationLabel = LocationLabel(type: .noSelected)
    private let tempLabel = UILabel().then {
        $0.font = UIFont.gmarketSansBoldFont(ofSize: 64)
        $0.textColor = UIColor.white
        $0.text = "--°"
    }
    private let weatherImageView = UIImageView().then{
        $0.image = UIImage(named: "sunny")
    }
    private var weatherDetailView = WeatherDiscriptionView(maxTemp: "--", minTemp: "--", feelTemp: "--", humidity: "--", dust: "--", fineDust: "--")
    private let notiButton = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "Notification"), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .mainThemeColor
        setTopViewLayout()
    }
    
    func setTopViewLayout(){
        self.view.backgroundColor = UIColor.mainThemeColor
        view.addSubviews([locationLabel, tempLabel, weatherImageView, weatherDetailView, notiButton])
        
        locationLabel.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().offset(-28)
            $0.height.equalTo(24)
        }
        tempLabel.snp.makeConstraints{
            $0.top.equalTo(locationLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(33)
            $0.width.equalTo(130)
            $0.height.equalTo(64)
        }
        weatherImageView.snp.makeConstraints{
            $0.top.equalTo(locationLabel.snp.bottom).offset(0)
            $0.trailing.equalToSuperview().offset(-28)
            $0.width.height.equalTo(128)
        }
        weatherDetailView.snp.makeConstraints{
            $0.top.equalTo(tempLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(33)
            $0.height.equalTo(75)
        }
        notiButton.snp.makeConstraints{
            $0.bottom.equalTo(weatherDetailView.snp.bottom)
            $0.trailing.equalTo(-15)
            $0.width.height.equalTo(36)
        }
    }
    
    

}
