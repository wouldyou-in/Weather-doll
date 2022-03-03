//
//  NetworkResult.swift
//  weather-doll
//
//  Created by 박익범 on 2022/02/28.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
