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
    private var locationLabel = LocationLabel(description: "")
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
    
    //firstView
    private let firstView = FirstScene()
    
    let head = CollectionHeaderView()
    
    var latitude: String = ""
    var longitude: String = ""
    
    var viewTranslation = CGPoint(x: 0, y: 0)
    var viewVelocity = CGPoint(x: 0, y: 0)
    
    var stateResult = [String]()
    
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
        view.addSubview(bottomSheetView)
        bottomSheetView.snp.makeConstraints{
            $0.bottom.leading.trailing.equalToSuperview().offset(0)
            $0.height.equalTo(600)
        }
        bottomSheetView.isHidden = true
        
        bottomSheetView.tableView.delegate = self
        bottomSheetView.tableView.dataSource = self
        bottomSheetView.searchBar.delegate = self

        bottomSheetView.searchBar.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    func pangestureAction(){
        bottomSheetView.frame = CGRect(x: 0, y: 0, width: UIScreen.getDeviceWidth(), height: UIScreen.getDeviceHeight() * 0.32)
        bottomSheetView.center = CGPoint(x: UIScreen.getDeviceWidth() / 2, y: UIScreen.getDeviceHeight() * 0.32)
           let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.drag))
        bottomSheetView.addGestureRecognizer(panGesture)
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
                           print(response)
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
    
    
    func setLocationStr() {
        let userDefault = UserDefaults.standard
        print(userDefault.bool(forKey: "isFirst"), "isFirst")
        
        if userDefault.bool(forKey: "isFirst") {
            setFirstView()
        }
        else {
            locationLabel.selectedLabel.text = userDefault.string(forKey: "locationName")
            locationLabel.selectedLabelDescription.text = "의 날씨입니다!"
        }
    }
    
    
    @objc private func locationLabelClicked(_ sender: Any){
        if (bottomSheetView.isHidden == true){
            bottomSheetView.presentAnimation()
        }
        bottomSheetView.isHidden = false
            bottomSheetView.snp.remakeConstraints{
                $0.bottom.leading.trailing.equalToSuperview().offset(0)
                $0.height.equalTo(UIScreen.getDeviceHeight() * 0.73)
            }
        }
    @objc private func firstViewClicked(_ sender: Any){
        firstView.isHidden = true
    }
     
}

extension HomeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionHeaderView", for: indexPath)
            print(headerView)
        return headerView
            
        default:
            assert(false)
        }
    }

    
}
extension HomeVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCVC", for: indexPath) as! RecommendCVC
        cell.setData(indexName: "패딩 지수", indexValue: "87", description: "두꺼운 오리털 패딩을 입어야 할 것 같아요.")
        
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
            UserDefaults.standard.set(false, forKey: "isFirst")
            UserDefaults.standard.set(location, forKey: "locationName")
            self.setLocationStr()
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
