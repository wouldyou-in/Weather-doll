//
//  InterfaceController.swift
//  watch-doll WatchKit Extension
//
//  Created by 박익범 on 2022/03/02.
//

import WatchKit
import UIKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController {
    let session = WCSession.default
    var longitude: String = ""
    var latitude: String = ""
    var temp: Double = 0.0
    
    @IBOutlet weak var locationLabel: WKInterfaceLabel!
    @IBOutlet weak var tempLabel: WKInterfaceLabel!
    @IBOutlet weak var iconImageView: WKInterfaceImage!
    
    @IBOutlet weak var tempDetailLabel: WKInterfaceLabel!
    @IBOutlet weak var humdityLabel: WKInterfaceLabel!
    @IBOutlet weak var dustLabel: WKInterfaceLabel!
    @IBOutlet weak var highDustLabel: WKInterfaceLabel!
    
    
    var clothModel = CellModel.clothModel
    var foodModel = CellModel.foodModel
    var pyshicalModel = CellModel.pyshicalModel
    var lifeModel = CellModel.lifeModel
    
    var sortedDict: [Dictionary<String, Int>.Element] = []
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        UserDefaults.standard.register(defaults: ["isFirst" : true])
        session.delegate = self
        session.activate()
        isEmptyData()
//         Configure interface objects here.
    }
    
    func tempCalcul(temp: Double) -> String{
        var str = temp - 273.15
        return String(Int(str))
    }
    
    func isEmptyData(){
        if UserDefaults.standard.bool(forKey: "isFirst")  == false{
            locationLabel.setText(UserDefaults.standard.string(forKey: "location"))
            latitude = UserDefaults.standard.string(forKey: "lati") ?? ""
            longitude = UserDefaults.standard.string(forKey: "long") ?? ""
            getWeatherDataFunc()
        }
    }
    
    func setTempData(temp: Double, minTemp: Double, maxTemp: Double, feelTemp: Double, hum: Int) {
        let minTemp = tempCalcul(temp: minTemp)
        let maxTemp = tempCalcul(temp: maxTemp)
        let feelTemp = tempCalcul(temp: feelTemp)
        let humidity = String(hum)
        let tempOrigin = maxTemp + "° / " + minTemp + "° 체감온도 : " + feelTemp + "°"
        let humdityOrigin = "습도 : " + humidity + "%"
        let dustOrigin = "미세먼지 : --"
        let highDustOrigin = "초 미세먼지 : --"
        dustLabel.setBoldAttributeText(targetString: ["--"], font: UIFont(name: "GmarketSansMedium", size: 12)!, originText: dustOrigin)
        highDustLabel.setBoldAttributeText(targetString: ["--"], font: UIFont(name: "GmarketSansMedium", size: 12)!, originText: highDustOrigin)
        tempLabel.setText(tempCalcul(temp: temp) + "°")
        tempDetailLabel.setBoldAttributeText(targetString: [maxTemp + "°", minTemp + "°", feelTemp +  "°"], font: UIFont(name: "GmarketSansMedium", size: 12)!, originText: tempOrigin)
        humdityLabel.setBoldAttributeText(targetString: [humidity + "%"], font: UIFont(name: "GmarketSansMedium", size: 12)!, originText: humdityOrigin)
        
    }

    private func getWeatherDataFunc(){
        GetWeatherDataService.shared.getWeatherData(lat: latitude, lon: longitude, appid: SecureURL.userID){ (response) in
                   switch response
                   {
                   case .success(let data) :
                       if let response = data as? WeatherDataModel{
                           self.temp = response.main.temp
                           self.setTempData(
                            temp: response.main.temp,
                            minTemp: response.main.tempMin,
                            maxTemp: response.main.tempMax,
                            feelTemp: response.main.feelsLike,
                            hum: response.main.humidity)
                           self.changeWeatherImage(weather: response.weather[0].icon)
                       }
                   case .requestErr(let message) :
                       print("requestERR")
                   case .pathErr :
                       print("pathERR")
                   case .serverErr:
                       print("serverERR")
                   case .networkFail:
                       print("networkFail")
                   }
            
               }
    }
    
    func changeWeatherImage(weather: String) {
        let date = Date()
        var currentTime: String = ""
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "HH"
        currentTime = dateformatter.string(from: date)
        
        //이건 고민좀
        switch weather{
        case "01d", "01n":
            if (Int(currentTime) ?? 0 > 06) && (Int(currentTime) ?? 0 < 18) {iconImageView.setImage(UIImage(named: "sunny"))}
            else {iconImageView.setImage(UIImage(named: "night"))}
        case "02d", "02n":
            iconImageView.setImage(UIImage(named: "cloudy"))
        case "03d", "03n":
            iconImageView.setImage(UIImage(named: "cloudy"))
        case "04d", "04n":
            iconImageView.setImage(UIImage(named: "cloudy"))
        case "09d", "09n", "10d", "10n":
            iconImageView.setImage(UIImage(named: "drizzle"))
        case "11d", "11n":
            iconImageView.setImage(UIImage(named: "thunderstroms"))
        case "13d", "13n":
            iconImageView.setImage(UIImage(named: "snow"))
        case "50d", "50n":
            iconImageView.setImage(UIImage(named: "fog"))
        default:
            print("error")
        }
    }
    
   
    
    override func willActivate() {
        super.willActivate()
        print("willActivate")
        isEmptyData()
        // This method is called when watch view controller is about to be visible to user

    }
    
    override func didDeactivate() {
        super.didDeactivate()
        print("didDeactivate")
        // This method is called when watch view controller is no longer visible

    }

}

extension InterfaceController: WCSessionDelegate {
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        if let value = userInfo["iPhone"] as? [String] {
            DispatchQueue.main.async {
                if let value = userInfo["iPhone"] as? [String]
                {
                    UserDefaults.standard.set(false, forKey: "isFirst")
                    self.longitude = value[0]
                    UserDefaults.standard.set(self.longitude, forKey: "long")
                    self.latitude = value[1]
                    UserDefaults.standard.set(self.latitude, forKey: "lati")
                    self.locationLabel.setText(value[2])
                    UserDefaults.standard.set(value[2], forKey: "location")
                    self.getWeatherDataFunc()
                }
            }
        }
    }
    func session(_ session: WCSession, didReceiveMessage message: [String : Any] = [:]) {
       if let value = message["iPhone"] as? String {
//         self.locationLabel.setText(value)
       }
     }
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any] = [:]) {
        if let value = applicationContext["iPhone"] as? String {
//          self.locationLabel.setText(value)
        }
    }
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if activationState == .activated {
        }

    }


}

