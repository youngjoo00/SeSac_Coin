//
//  ErrorStatus.swift
//  SeSac_Coin
//
//  Created by youngjoo on 3/2/24.
//

import Foundation

enum ErrorStatus: String, Error {
    case failedRequest = "네트워크 통신이 실패했습니다."
    case invalidResponse = "서버로부터 올바른 응답을 받지 못했습니다."
    case invalidData = "데이터를 불러오는데 문제가 발생했습니다."
    case noData = "서버로부터 데이터를 받지 못했습니다."
}
