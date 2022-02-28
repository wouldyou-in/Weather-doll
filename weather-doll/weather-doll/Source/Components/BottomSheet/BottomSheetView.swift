//
//  BottomSheetView.swift
//  weather-doll
//
//  Created by 박익범 on 2022/02/28.
//

import UIKit
import SnapKit
import Then

class BottomSheetView: UIView {
    private let topBarImageView = UIImageView().then{
        $0.image = UIImage(named: "topHandle")
    }
    let searchBar = SearchBar()
    let tableView = UITableView().then{
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setLayout(){
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        
        addSubviews([topBarImageView, searchBar, tableView])
        
        tableView.register(SearchTVC.self, forCellReuseIdentifier: "SearchTVC")
        tableView.separatorStyle = .none
        
        topBarImageView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(17)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(36)
            $0.height.equalTo(5)
        }
        
        searchBar.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().offset(-28)
            $0.top.equalTo(topBarImageView.snp.bottom).offset(16)
            $0.height.equalTo(36)
        }
        
        tableView.snp.makeConstraints{
            $0.top.equalTo(searchBar.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(33)
            $0.trailing.equalToSuperview().offset(-33)
            $0.bottom.equalToSuperview().offset(0)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    init(){
        super.init(frame: .zero)
        setLayout()

    }
    
}
