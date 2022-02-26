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
    let head = CollectionHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .mainThemeColor
        collectionViewSetting()
        setTopViewLayout()
        setRecommendViewLayout()
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
