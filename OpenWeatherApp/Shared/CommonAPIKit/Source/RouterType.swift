//
//  Router.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/1/24.
//

import Foundation

protocol RouterType {
  
  /// API의 기본 URL
  var baseUrl: String { get }
  /// 엔드포인트 경로
  var path: String { get }
  /// HTTP 메서드
  var method: HTTPMethod { get }
  /// HTTP 헤더
  var headers: [String: String]? { get }
  /// URL 파라미터
  var parameters: [String: Any]? { get }
  /// HTTP Body
  var body: Data? { get }
}
