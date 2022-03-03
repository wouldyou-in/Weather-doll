//
//  UserDefaults+.swift
//  weather-doll
//
//  Created by 박익범 on 2022/03/02.
//

import Foundation


extension UserDefaults {
    static var shared: UserDefaults {
        let combined = UserDefaults.standard
        let appGroupId = "group.share.weatherData"
        combined.addSuite(named: appGroupId)
        return combined
    }
}
