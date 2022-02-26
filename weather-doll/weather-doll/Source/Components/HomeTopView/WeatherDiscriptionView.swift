//
//  WeatherDiscription.swift
//  weather-doll
//
//  Created by 박익범 on 2022/02/26.
//

import UIKit
import SnapKit
import Then

class WeatherDiscriptionView: UIView {
    var maxTemp: String = ""
    var minTemp: String = ""
    var feelTemp: String = ""
    var humidity: String = ""
    var dust: String = ""
    var fineDust: String = ""
    
    
    var maxMinFeelTempLabel = UILabel().then{
        $0.font = UIFont.gmarketSansLightFont(ofSize: 14)
        $0.textColor = UIColor.white
    }
    var humidityLabel = UILabel().then{
        $0.font = UIFont.gmarketSansLightFont(ofSize: 14)
        $0.textColor = UIColor.white
    }
    var dustLabel = UILabel().then{
        $0.font = UIFont.gmarketSansLightFont(ofSize: 14)
        $0.textColor = UIColor.white
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    init(maxTemp: String, minTemp: String, feelTemp: String, humidity: String, dust: String, fineDust: String){
        super.init(frame: .zero)
        
        self.maxTemp = maxTemp
        self.minTemp = minTemp
        self.feelTemp = feelTemp
        self.humidity = humidity
        self.dust = dust
        self.fineDust = fineDust
        
        setLayout()
        setWeatherData()
    }
    
    func setLayout(){
        addSubviews([maxMinFeelTempLabel, humidityLabel, dustLabel])
        
        maxMinFeelTempLabel.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview().offset(0)
            $0.height.equalTo(24)
        }
        humidityLabel.snp.makeConstraints{
            $0.top.equalTo(maxMinFeelTempLabel.snp.bottom).offset(0)
            $0.leading.trailing.equalToSuperview().offset(0)
            $0.height.equalTo(24)
        }
        dustLabel.snp.makeConstraints{
            $0.top.equalTo(humidityLabel.snp.bottom).offset(0)
            $0.leading.trailing.equalToSuperview().offset(0)
            $0.height.equalTo(24)
        }
    }
    func setWeatherData() {
        let maxMinFeelTempStr = maxTemp + "° / " + minTemp + "° 체감온도 : " + feelTemp + "°"
        let humidityStr = "습도 : " + humidity + "%"
        let dustStr = "미세먼지 : " + dust + " / 초 미세먼지 : " + fineDust
        
        maxMinFeelTempLabel.text = maxMinFeelTempStr
        humidityLabel.text = humidityStr
        dustLabel.text = dustStr
        
        maxMinFeelTempLabel.setBoldAttributeText(targetString: [maxTemp + "°", minTemp + "°", feelTemp + "°"], font: UIFont.gmarketSansMediumFont(ofSize: 14))
        humidityLabel.setBoldAttributeText(targetString: [humidity + "%"], font: UIFont.gmarketSansMediumFont(ofSize: 14))
        dustLabel.setBoldAttributeText(targetString: [dust, fineDust], font: UIFont.gmarketSansMediumFont(ofSize: 14))
    }
    
}
