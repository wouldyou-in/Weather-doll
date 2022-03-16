//
//  HomeVC.swift
//  weather-doll
//
//  Created by 박익범 on 2022/02/26.
//

import UIKit
import SnapKit
import Then
import WatchConnectivity

class HomeVC: UIViewController {
    //topView
    private var locationLabel = LocationLabel(description: "")
    private let tempLabel = UILabel().then {
        $0.font = UIFont.gmarketSansBoldFont(ofSize: 64)
        $0.textColor = UIColor.white
        $0.text = "--°"
    }
    private var weatherImageView = UIImageView().then{
        $0.image = UIImage(named: "sunny")
    }
    private var weatherDetailView = WeatherDiscriptionView(maxTemp: "--", minTemp: "--", feelTemp: "--", humidity: "--", dust: "--", fineDust: "--")
    private let notiButton = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "Notification"), for: .normal)
    }
    //recommendView
    private let recommendBackgroundView = UIView().then{
        $0.backgroundColor = UIColor.subThemeColor
    }
    private let headerView = CollectionHeaderView()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        $0.setCollectionViewLayout(layout, animated: false)
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.backgroundColor = .none
        $0.bounces = true
        $0.showsVerticalScrollIndicator = false
    }
    //bottomSheet
    private let bottomSheetView = BottomSheetView()
    private let bottomSheetBackgroundView = UIView().then{
        $0.backgroundColor = UIColor.black.withAlphaComponent(0)
    }
    //firstView
    private let firstView = FirstScene()
    
    let head = CollectionHeaderView()
    
    var latitude: String = ""
    var longitude: String = ""
    
    var viewTranslation = CGPoint(x: 0, y: 0)
    var viewVelocity = CGPoint(x: 0, y: 0)
    
    var stateResult = [String]()
    var temp: Int = 0
    
    var isNotiClicked: Bool = false
    var selectTimeStr: String = ""
    
    //dataModel
    var allModel = CellModel.allModel
    var clothModel = CellModel.clothModel
    var foodModel = CellModel.foodModel
    var pyshicalModel = CellModel.pyshicalModel
    var lifeModel = CellModel.lifeModel
    
    var recommendText: String = "전체"
    var sortedDict: [Dictionary<String, Int>.Element] = []
    var allModelDict: [Dictionary<String, Int>.Element] = []
    
    //watch
    var session: WCSession?
    
    //notiView
    private let notiView = NotiAlertView()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getWeatherData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .mainThemeColor
        collectionViewSetting()
        setTopViewLayout()
        setRecommendViewLayout()
        pangestureAction()
        bottomSheetSetting()
        setLocationStr()
        setAllmodelSorting()
        configureWatchKitSession()
        dataSend()
        setNotiAlertViewLayout()
    }
    func setNotiAlertViewLayout(){
        self.view.addSubview(notiView)
        
        notiView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(200)
            $0.leading.trailing.equalToSuperview().offset(0)
            $0.height.equalTo(350)
        }
        
        notiView.isHidden = true
    }
    
    func setTopViewLayout(){
        self.view.backgroundColor = UIColor.mainThemeColor
        view.addSubviews([locationLabel, tempLabel, weatherImageView, weatherDetailView, notiButton])
        
        locationLabel.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
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
        
        notiButton.addTarget(self, action: #selector(notiButtonClicked(_:)), for: .touchUpInside)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(locationLabelClicked(_:)))
        locationLabel.addGestureRecognizer(gesture)
        locationLabel.isUserInteractionEnabled = true
    }
    
    func setRecommendViewLayout(){
        view.addSubview(recommendBackgroundView)
        recommendBackgroundView.addSubview(collectionView)
        collectionView.addSubview(head)
        
        
        recommendBackgroundView.snp.makeConstraints{
            $0.top.equalTo(weatherDetailView.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview().offset(0)
        }
        collectionView.snp.makeConstraints{
            $0.top.leading.bottom.trailing.equalToSuperview().offset(0)
        }
        
    }
    func collectionViewSetting(){
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(RecommendCVC.self, forCellWithReuseIdentifier: "RecommendCVC")
        collectionView.register(CollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionHeaderView")
        
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize = .zero
    }
    func bottomSheetSetting(){
        let height = UIScreen.getDeviceHeight() * 0.73
        
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(bottomSheetBackgroundView)
        view.addSubview(bottomSheetView)

        bottomSheetView.snp.makeConstraints{
            $0.leading.bottom.trailing.equalToSuperview().offset(0)
            $0.height.equalTo(0)
        }
        bottomSheetBackgroundView.snp.makeConstraints{
            $0.bottom.leading.trailing.equalTo(view).offset(0)
            $0.top.equalToSuperview().offset(0)
        }
        bottomSheetBackgroundView.isHidden = true
        bottomSheetView.isHidden = true
        
        bottomSheetView.tableView.delegate = self
        bottomSheetView.tableView.dataSource = self
        bottomSheetView.searchBar.delegate = self

        bottomSheetView.searchBar.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(bottomSheetBackgroundClicked(_:)))
        bottomSheetBackgroundView.addGestureRecognizer(gesture)
        bottomSheetBackgroundView.isUserInteractionEnabled = true
    }
    
    func pangestureAction(){
        bottomSheetView.frame = CGRect(x: 0, y: 0, width: UIScreen.getDeviceWidth(), height: UIScreen.getDeviceHeight() * 0.32)
        bottomSheetView.center = CGPoint(x: UIScreen.getDeviceWidth() / 2, y: UIScreen.getDeviceHeight() * 0.32)
           let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.drag))
        bottomSheetView.addGestureRecognizer(panGesture)
    }
    func dimissNotiAlert() {
        if isNotiClicked {
            isNotiClicked = false
            notiView.isHidden = true
            bottomSheetBackgroundView.isHidden = true
        }
    }
    @objc func notiButtonClicked (_ sender: UIButton) {
        if isNotiClicked == false {
            isNotiClicked = true
            notiView.isHidden = false
            bottomSheetBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            bottomSheetBackgroundView.isHidden = false
        }
        notiView.dateCompletion = { str in
            if str == "취소" {
                self.dimissNotiAlert()
            }
            else {
                self.selectTimeStr = str
                print(self.selectTimeStr, "선택한 시간")
                self.dimissNotiAlert()
            }
            return str
        }
    }
    @objc func drag(sender: UIPanGestureRecognizer) {
        viewTranslation = sender.translation(in: bottomSheetView)
        viewVelocity = sender.translation(in: bottomSheetView)
        switch sender.state {
        case .changed:
            if viewVelocity.y < 0 {
                bottomSheetView.snp.remakeConstraints{
                    $0.bottom.leading.trailing.equalToSuperview().offset(0)
                    $0.height.equalTo(UIScreen.getDeviceHeight() * 0.73)
                }
            }
            else {
                bottomSheetView.snp.remakeConstraints{
                    $0.bottom.leading.trailing.equalToSuperview().offset(0)
                    $0.height.equalTo((UIScreen.getDeviceHeight() * 0.73) - viewVelocity.y)
                }
                bottomSheetBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5 - (viewVelocity.y * 0.002))

            }
        case .ended:
            if viewTranslation.y < 200 {
                bottomSheetView.snp.remakeConstraints{
                    $0.bottom.leading.trailing.equalToSuperview().offset(0)
                    $0.height.equalTo(UIScreen.getDeviceHeight() * 0.73)
                }
            }
            else {
                bottomSheetView.isHidden = true
                bottomSheetBackgroundView.isHidden = true
                bottomSheetView.snp.updateConstraints{
                    $0.height.equalTo(0)
                }
                bottomSheetBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0)
            }
          
        default:
            print("error")
            break
        }
    }

    func getWeatherData(){
        GetWeatherDataService.shared.getWeatherData(lat: latitude, lon: longitude, appid: SecureURL.userID){ (response) in
                   switch response
                   {
                   case .success(let data) :
                       if let response = data as? WeatherDataModel{
                           self.setTempData(
                            temp: response.main.temp,
                            minTemp: response.main.tempMin,
                            maxTemp: response.main.tempMax,
                            feelTemp: response.main.feelsLike,
                            hum: response.main.humidity)
                           self.changeWeatherImage(weather: response.weather[0].icon)
                           self.collectionView.reloadData()
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

    func tempCalcul(temp: Double) -> String{
        var str = temp - 273.15
        return String(Int(str))
    }
    
    func setTempData(temp: Double, minTemp: Double, maxTemp: Double, feelTemp: Double, hum: Int) {
        tempLabel.text = tempCalcul(temp: temp) + "°"
        weatherDetailView.minTemp = tempCalcul(temp: minTemp)
        weatherDetailView.maxTemp = tempCalcul(temp: maxTemp)
        weatherDetailView.feelTemp = tempCalcul(temp: feelTemp)
        weatherDetailView.humidity = String(hum)
        
        weatherDetailView.setWeatherData()
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
            if (Int(currentTime) ?? 0 > 06) && (Int(currentTime) ?? 0 < 18) {weatherImageView.image = UIImage(named: "sunny")}
            else {weatherImageView.image = UIImage(named: "night")}
        case "02d", "02n":
            weatherImageView.image = UIImage(named: "cloudy")
        case "03d", "03n":
            weatherImageView.image = UIImage(named: "cloudy")
        case "04d", "04n":
            weatherImageView.image = UIImage(named: "cloudy")
        case "09d", "09n", "10d", "10n":
            weatherImageView.image = UIImage(named: "drizzle")
        case "11d", "11n":
            weatherImageView.image = UIImage(named: "thunderstroms")
        case "13d", "13n":
            weatherImageView.image = UIImage(named: "snow")
        case "50d", "50n":
            weatherImageView.image = UIImage(named: "fog")
        default:
            print("error")
        }
    }
    
    
    
    func setFirstView() {
        UserDefaults.standard.set(true, forKey: "isFirst")
        if UserDefaults.standard.bool(forKey: "isFirst") {
            view.addSubview(firstView)
            firstView.setLayout(locView: locationLabel, notiButton: notiButton)
            firstView.snp.makeConstraints{
                $0.top.bottom.leading.trailing.equalTo(0)
            }
        }
       
        let gesture = UITapGestureRecognizer(target: self, action: #selector(firstViewClicked(_:)))
        firstView.addGestureRecognizer(gesture)
        firstView.isUserInteractionEnabled = true
    }
    func configureWatchKitSession(){
        if WCSession.isSupported() {
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
        
    }
    func dataSend(){
        if let validSession = self.session, validSession.isReachable {
            var longLati = [longitude, latitude, locationLabel.selectedLabel.text]
            let data: [String: Any] = ["iPhone": longLati as Any]
            validSession.transferUserInfo(data)
            validSession.sendMessage(data, replyHandler: nil, errorHandler: nil)
        }
    }
    
    
    func setLocationStr() {
        UserDefaults.standard.register(defaults: ["isFirst" : true])

        
        let userDefault = UserDefaults.shared
        print(userDefault.bool(forKey: "isFirst"), "isFirst")
        
        if userDefault.bool(forKey: "isFirst") {
            setFirstView()
        }
        else {
            locationLabel.selectedLabel.text = userDefault.string(forKey: "locationName")
            locationLabel.selectedLabelDescription.text = "의 날씨입니다!"
            
            var locationStr = removeSpaceStr(text: userDefault.string(forKey: "locationName") ?? "") ?? ""
            
            longitude = locationModel.longlatiDict[locationStr]?[0] ?? ""
            latitude = locationModel.longlatiDict[locationStr]?[1] ?? ""
            
            getWeatherData()
        }
    }
    
    func removeSpaceStr(text: String) -> String {
        let str = text.replacingOccurrences(of: " ", with: "")
        return str
    }
    @objc private func locationLabelClicked(_ sender: Any){
        bottomSheetView.isHidden = false
        bottomSheetBackgroundView.isHidden = false
        bottomSheetView.presentAnimation()
        bottomSheetBackgroundView.changeColor()
        dataSend()
    }
    
    @objc private func firstViewClicked(_ sender: Any){
        firstView.isHidden = true
    }
    @objc private func bottomSheetBackgroundClicked(_ sender: Any) {
        bottomSheetView.dismissAnimation(view: bottomSheetBackgroundView)
        dimissNotiAlert()
    }
    func sortDict(dic: [String: Int]) -> [Dictionary<String, Int>.Element] {
        let sorted = dic.sorted {$0.1 > $1.1}
        return sorted
    }
    func setAllmodelSorting() {
        sortedDict = sortDict(dic: allModel)
    }
    func setDescription(index: IndexPath) -> String{
        switch recommendText {
        case "전체":
            return CellModel.allModelCheck(obj: sortedDict[index.row].key, index: sortedDict[index.row].value, temp: temp)
        case "의류":
            return CellModel.checkCloth(cloths: sortedDict[index.row].key, index: sortedDict[index.row].value, temp: temp)
        case "음식":
            return CellModel.checkFood(food: sortedDict[index.row].key, index: sortedDict[index.row].value, temp: temp)
        case "활동":
            return CellModel.checkExercise(exercise: sortedDict[index.row].key, index: sortedDict[index.row].value, temp: temp)
        case "생활":
            return CellModel.checkLife(life: sortedDict[index.row].key, index: sortedDict[index.row].value, temp: temp)
        default:
            return "setDescriptionErr"
        }
    }

     
}

extension HomeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch recommendText {
        case "전체":
            return allModel.count
        case "의류":
            return clothModel.count
        case "음식":
            return foodModel.count
        case "활동":
            return pyshicalModel.count
        case "생활":
            return lifeModel.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionHeaderView", for: indexPath) as! CollectionHeaderView
            headerView.recommendButtonCompletion = {
                text in
                switch text{
                case "전체":
                    self.recommendText = text
                    self.sortedDict = self.sortDict(dic: self.allModel)
                    self.collectionView.reloadData()
                case "의류":
                    self.recommendText = text
                    self.sortedDict = self.sortDict(dic: self.clothModel)
                    self.collectionView.reloadData()
                case "음식":
                    self.recommendText = text
                    self.sortedDict = self.sortDict(dic: self.foodModel)
                    self.collectionView.reloadData()
                case "활동":
                    self.recommendText = text
                    self.sortedDict = self.sortDict(dic: self.pyshicalModel)
                    self.collectionView.reloadData()
                case "생활":
                    self.recommendText = text
                    self.sortedDict = self.sortDict(dic: self.lifeModel)
                    self.collectionView.reloadData()
                default:
                    print("Error")
                }
                return text
            }
        return headerView
            
        default:
            assert(false)
        }
        return UICollectionReusableView()
    }

    
}
extension HomeVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCVC", for: indexPath) as! RecommendCVC
        
        let descript = setDescription(index: indexPath)
                
        cell.setData(indexName: sortedDict[indexPath.row].key,
                     indexValue: String(sortedDict[indexPath.row].value),
                     description: descript)
//        cell.setData(indexName: "패딩 지수", indexValue: "87", description: "두꺼운 오리털 패딩을 입어야 할 것 같아요.")
        
        return cell
    }
    
    
}
extension HomeVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 12
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 23
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 23, bottom: 0, right: 23)
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.getDeviceWidth(), height: 80)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 155, height: 180)
    }
}

extension HomeVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
extension HomeVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stateResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTVC.identifier) as! SearchTVC
        cell.selectionStyle = .none
        cell.setData(city: stateResult[indexPath.row])
                
        cell.selectButtonCompletion = {
            location in
            UserDefaults.shared.set(false, forKey: "isFirst")
            UserDefaults.shared.set(location as? String, forKey: "locationName")
            self.setLocationStr()
            self.dataSend()
            return location
        }
        return cell
    }
    
}
extension HomeVC: UITextFieldDelegate {
    func searchState(){
        var stateArr = locationModel.cityArr
        var text = bottomSheetView.searchBar.text ?? ""
        var start = 0
        var answer = [Int]()
        stateResult = []
        var t = String()
        
        for state in stateArr{
            t = state
            while let range = t.range(of: text) {
                start += t.distance(from: t.startIndex, to: range.lowerBound)
                answer.append(start)
                start += t.distance(from: t.startIndex, to: range.upperBound) - 1
                t = String(t[range.upperBound...])
                stateResult.append(state)
            }
        }
    }
    
    @objc func textFieldDidChange(_ sender: Any?) {
        searchState()
        bottomSheetView.tableView.reloadData()
    }
}

extension HomeVC: WCSessionDelegate {
    func sessionDidBecomeInactive(_ session: WCSession) {
        let data: [String: Any] = ["iPhone": locationLabel.selectedLabel.text as Any]
        session.transferUserInfo(data)
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        let data: [String: Any] = ["iPhone": locationLabel.selectedLabel.text as Any]
        session.transferUserInfo(data)
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
}
