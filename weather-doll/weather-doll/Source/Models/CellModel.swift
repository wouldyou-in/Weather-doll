//
//  CellModel.swift
//  weather-doll
//
//  Created by 박익범 on 2022/03/01.
//

import Foundation


struct CellModel {
    static let clothModel: [String: Int] = ["가디건 지수": 90, "셔츠 지수": 30, "원피스 지수": 12, "니트 지수": 90, "맨투맨 지수": 90, "후드티 지수": 90, "반팔 지수": 90, "반바지 지수": 45, "민소매 지수": 65, "샌들 지수": 5, "자켓 지수": 90, "패딩 지수": 10, "코트 지수": 32, "후리스 지수": 90, "히트텍 지수": 10, "청바지 지수": 11, "슬랙스 지수": 23]
    static let foodModel: [String: Int] = ["보양음식 지수": 12, "빙수 지수": 90, "수박 지수": 90, "맥주 지수": 90, "냉면 지수": 90, "뜨끈한 탕 지수": 90, "겨울간식 지수": 90, "소주 지수": 90, "핫초코 지수": 90, "포장마차 지수": 90, "파전에 막걸리 지수": 90, "삼겹살 지수": 90,  "짜장면 지수": 90]
    static let pyshicalModel: [String: Int] = ["등산 지수": 1, "자전거 지수": 90, "실내 스포츠": 90, "수영 지수": 90, "서핑 지수": 90, "스키 지수": 90, "스케이트 지수": 90]
    static let lifeModel: [String: Int] = ["빨래 지수": 12, "나들이 지수": 90, "세차 지수": 90, "우산 지수": 90, "수면 지수": 90, "감기 지수": 90, "불조심 지수": 90, "냉방 지수": 35, "난방 지수": 90, "내피부는소중해 지수": 90, "눈사람/눈싸움 지수": 90]
    
    static let allModel: [String: Int] = ["가디건 지수": 45, "셔츠 지수": 30, "원피스 지수": 12, "니트 지수": 90, "맨투맨 지수": 90, "후드티 지수": 90, "반팔 지수": 90, "반바지 지수": 65, "민소매 지수": 65, "샌들 지수": 5, "자켓 지수": 90, "패딩 지수": 10, "코트 지수": 32, "후리스 지수": 90, "히트텍 지수": 10, "청바지 지수": 11, "슬랙스 지수": 23, "보양음식 지수": 90, "아이스크림 지수": 90, "수박 지수": 90, "맥주 지수": 6, "냉면 지수": 90, "뜨끈한 탕 지수": 90, "겨울간식 지수": 90, "소주 지수": 90, "핫초코 지수": 90, "포장마차 지수": 90, "파전에 막걸리 지수": 90, "삼겹살 지수": 90,  "짜장면 지수": 90, "등산 지수": 90, "자전거 지수": 90, "실내 스포츠": 90, "수영 지수": 90, "서핑 지수": 5, "스키 지수": 54, "스케이트 지수": 90, "빨래 지수": 90, "나들이 지수": 90, "세차 지수": 90, "우산 지수": 90, "수면 지수": 90, "감기 지수": 90, "불조심 지수": 90, "냉방 지수": 90, "난방 지수": 90, "내피부는소중해 지수": 90, "눈사람/눈싸움 지수": 90]
    
    static func allModelCheck(obj: String, index: Int, temp: Int) -> String{
        print(obj)
        switch obj {
        case "가디건 지수", "셔츠 지수", "원피스 지수", "니트 지수", "맨투맨 지수", "후드티 지수", "자켓 지수", "반팔 지수", "반바지 지수", "민소매 지수", "샌들 지수", "코트지수", "후리스 지수", "패딩 지수", "히트텍 지수":
            return checkCloth(cloths: obj, index: index, temp: temp)
        case "보양음식 지수", "빙수 지수", "수박 지수", "맥주 지수", "냉면 지수", "뜨끈한 탕 지수", "겨울간식 지수", "소주 지수", "핫초코 지수", "포장마차 지수", "파전에 막걸리 지수", "삼겹살 지수",  "짜장면 지수":
            return checkFood(food: obj, index: index, temp: temp)
        case "등산 지수", "자전거 지수", "실내 스포츠", "수영 지수", "서핑 지수", "스키 지수", "스케이트 지수":
            return checkExercise(exercise: obj, index: index, temp: temp)
        case "빨래 지수", "나들이 지수", "세차 지수", "우산 지수", "수면 지수", "감기 지수", "불조심 지수", "냉방 지수", "난방 지수", "내피부는소중해 지수", "눈사람/눈싸움 지수":
            return checkLife(life: obj, index: index, temp: temp)
        default:
            return obj + "Error"
        }
        return "Error not in switch-case"
    }
    
    
    static func checkCloth(cloths: String, index: Int, temp: Int) -> String{
        var cloth = cloths.replacingOccurrences(of: " 지수", with: "")
        switch cloths {
        case "가디건 지수", "셔츠 지수", "원피스 지수", "니트 지수", "맨투맨 지수", "후드티 지수", "자켓 지수":
            if index >= 81 {
                return cloth + "입기 좋은 날씨에요!"
            }
            else if (index >= 61) && (index <= 81) {
                if temp < 12 {
                    return cloth + "을 입기엔 살짝 추워요"
                }
                if temp > 20 {
                    return cloth + "을 입기엔 살짝 더워요"
                }
            }
            else if (index <= 60){
                return cloth + "을 추천하지 않아요"
            }
        case "반팔 지수", "반바지 지수", "민소매 지수", "샌들 지수":
            if index >= 81 {
                return "시원한 " + cloth + "를 입어보세요!"
            }
            else if (index >= 61) && (index <= 81) {
                return cloth + "을 입기엔 살짝 추운 날씨에요"
            }
            else if (index <= 60){
                return cloth + "을 입는다면 동태가 되버려요"
            }
        case "코트지수", "후리스 지수":
            if index >= 81 {
                return "멋을 아는 당신, " + cloth + "을 입어보세요!"
            }
            else if (index >= 61) && (index <= 81) {
                let indexArr = ["비록 추워도, " + cloth + "만은 포기 못하죠", cloth + "을 입기엔 더울꺼에요"]
                return indexArr.randomElement() ?? ""
            }
            else if (index <= 60){
                if (temp > 6) {
                    return cloth + "을 입기엔 너무 더워요"
                }
                if (temp > -2) {
                    return cloth + "을 입기엔 너무 추워요"
                }
            }
        case "패딩 지수", "히트텍 지수":
            if index >= 81 {
                return cloth + "을 입지 않고선 버틸수 없어요"
            }
            else if (index >= 61) && (index <= 81) {
                return cloth + "을 입기엔 좀 따뜻해졌어요"
            }
            else if (index <= 60){
                return "너무 더워요! " + cloth + "은 입지마세요!"
            }
        default:
            return "Error" + cloths
        }
        return "not calculate in func"
    }
    
    
    static func checkFood(food: String, index: Int, temp: Int) -> String {
        switch index {
        case 71 ... 100:
            switch food
            {
            case "보양음식 지수":
                return "이열치열의 계절, 몸보양이 필요해요"
            case "빙수 지수":
                return "시원한 빙수 한그릇 어떠신가요"
            case "수박 지수":
                return "요즘 수박이 제철이에요!"
            case "맥주 지수":
                return "밤하늘을 안주삼아 시원한 맥주 한잔 어떠신가요"
            case "냉면 지수":
                if temp < 2{
                    return "이냉치냉! 추운날 먹는 냉면이 또 별미죠"
                }
                else{
                return "더운날은 역시 시원한 냉면이죠!"
                }
            case "뜨끈한 탕 지수":
                return "입김까지 얼어붙는 날씨! 탕은 어떠신가요?"
            case "겨울 간식 지수":
                return "돌아왔다 겨울 간식의 계절이"
            case "소주 지수":
                return "밤 하늘의 달을 벗삼아, 소주한잔 어떠신가요"
            case "핫초코 지수":
                return "핫초코 한잔의 여유를 느껴보세요"
            case "포장마차 지수":
                return "조심하세요! 나도 모르게 포장마차로 이끌리는 날이에요"
            case "파전에 막걸리 지수":
                return "빗 소리가 막걸리를 부르는 날!"
            case "삼겹살 지수":
                return "칼칼한 목엔 삼겹살 기름이 직빵이에요!"
            case "짜장면":
                return "이사한 뒤엔 짜장면 한그릇 어떠신가요"
            default:
                return "Error" + food
            }
        default:
            switch food
            {
            case "보양음식 지수":
                return "다음 더위를 기다리고 있어요"
            case "빙수 지수":
                return "가끔씩 빙수한그릇이 생각날때도 있죠"
            case "수박 지수":
                return "가끔 수박이 생각나긴 해요"
            case "맥주 지수":
                return "술은 적당히 마시는걸 추천드려요"
            case "냉면 지수":
                return "가끔씩 시원한 냉면이 끌리는 날도 있죠"
            case "뜨끈한 탕 지수":
                return "가끔씩 따뜻한 국물이 생각나요"
            case "겨울 간식 지수":
                return "내년 겨울을 기다리는 중이에요"
            case "소주 지수":
                return "술은 적당히 마시는걸 추천드려요"
            case "핫초코 지수":
                return "핫 보단 아이스가 끌리는 날씨에요"
            case "포장마차 지수":
                return "적당한 떄를 노리고 있어요"
            case "파전에 막걸리 지수":
                return "사실 비가 안와도 파전에 막거리는 맛있어요"
            case "삼겹살 지수":
                return "사실은, 삼겹살은 미세먼지와 관련이 없대요"
            case "짜장면":
                return "가끔은 짜장면이 생각날때도 있어요"
            default:
                return "Error" + food
            }
            
        }
    }
    
    static func checkExercise(exercise: String, index: Int, temp: Int) -> String {
        switch index {
        case 71 ... 100:
            switch exercise
            {
            case "등산 지수":
                return "산의 기운을 느껴보아요"
            case "조깅 지수":
                return "가벼운 조깅으로 몸을 움직여보세요!"
            case "자전거 지수":
                return "자전거 타러가기 좋은 날입니다!"
            case "실내 스포츠 지수":
                return "미세먼지가 나쁜 오늘, 실내에서 운동을 즐겨보세요!"
            case "수영 지수":
                return "시원한 물살을 갈라보세요! "
            case "서핑 간식 지수":
                return "바람과 파도를 느끼러가요!"
            case "스키 지수":
                return "설원을 가로지르며 속도를 즐겨보세요!"
            case "스케이트 지수":
                return "스케이트 타기 좋은 날씨에요"
            default:
                return "Error" + exercise
            }
        default:
            switch exercise
            {
            case "등산 지수":
                if temp > 25 {
                    return "날이 너무 더워요! 옷차림에 주의하며 등산하세요!"
                }
                else if temp < 5 {
                    return "날이 너무 추워요! 옷차림에 주의하며 등산하세요!"
                }
                else {
                    return "옷차림에 주의하며 등산하세요!"
                }
            case "조깅 지수":
                return "조깅에 적합하지 않은 날씨에요, 몸 관리에 주의하세요!"
            case "자전거 지수":
                return "안좋은 날입니다!"
            case "실내 스포츠 지수":
                return "다양한 운동을 하기에 좋은 날 이에요!"
            case "수영 지수":
                return "다양한 운동을 하기에 좋은 날 이에요"
            case "서핑 간식 지수":
                return "다음 파도를 기다리고 있어요..."
            case "스키 지수":
                return "다음 계절을 기다리고있어요.."
            case "스케이트 지수":
                return "다음 계절을 기다리고있어요.."
            default:
                return "Error" + exercise
            }
        }
    }

    static func checkLife(life: String, index: Int, temp: Int) -> String {
        switch index {
        case 71 ... 100:
            switch life
            {
            case "빨래 지수":
                return "hello world"
            case "나들이 지수":
                return "hello world"
            case "세차 지수":
                return "hello world"
            case "우산 스포츠 지수":
                return "hello world"
            case "수면 지수":
                return "hello world "
            case "감기 지수":
                return "hello world"
            case "불조심 지수":
                return "hello world"
            case "냉방 지수":
                return "hello world"
            case "난방 지수":
                return "hello world"
            case "내피부는소중해 지수":
                return "hello world"
            case "눈사람/눈싸움 지수":
                return "hello world"
            default:
                return "Error" + life
            }
        default:
            switch life
            {
            case "빨래 지수":
                return "hello world"
            case "나들이 지수":
                return "hello world"
            case "세차 지수":
                return "hello world"
            case "우산 스포츠 지수":
                return "hello world"
            case "수면 지수":
                return "hello world "
            case "감기 지수":
                return "hello world"
            case "불조심 지수":
                return "hello world"
            case "냉방 지수":
                return "hello world"
            case "난방 지수":
                return "hello world"
            case "내피부는소중해 지수":
                return "hello world"
            case "눈사람/눈싸움 지수":
                return "hello world"
            default:
                return "Error" + life
            }
        }
    }
    
}
