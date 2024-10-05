//
//  APIClient.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/1/24.
//

import Foundation
import Combine

protocol APIClientType: AnyObject {
  associatedtype Router: RouterType
  
  func request<R: Decodable>(_ router: Router, _ responseType: R.Type) async throws -> R
}

final class APIClient<Router: RouterType>: APIClientType {
  
  func request<R: Decodable>(_ router: Router, _ responseType: R.Type) async throws -> R {
    let request = try router.asURLRequest()
    print(request)
    let (data, response) = try await URLSession.shared.data(for: request)
    try validateResponse(response)
    return try decodeData(data, as: responseType)
  }
}

private extension APIClient {
  
  /// 공통 응답 데이터 검증 메서드
  func validateResponse(_ response: URLResponse) throws {
    guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
      throw APIClientError.invalidResponse
    }
  }
  
  /// 공통 데이터 디코딩 메서드
  func decodeData<R: Decodable>(_ data: Data, as responseType: R.Type) throws -> R {
    do {
      let decodedObject = try JSONDecoder().decode(R.self, from: data)
      return decodedObject
    } catch {
      throw APIClientError.decodingError
    }
  }
}

private extension RouterType {
  
  /// URLRequest로 변환하는 메서드
  func asURLRequest() throws -> URLRequest {
    
    // URL 생성
    guard let url = URL(string: baseUrl)?.appendingPathComponent(path) else {
      throw APIClientError.invalidURL
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    
    // 헤더 설정
    if let headers {
      for (key, value) in headers {
        request.setValue(value, forHTTPHeaderField: key)
      }
    }
    
    // 파라미터가 있는 경우 URL에 쿼리 스트링을 추가
    if method == .get, let parameters = parameters {
      var urlComponents = URLComponents(string: url.absoluteString)
      urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
      request.url = urlComponents?.url
    } else {
      // POST, PUT 등에서 body 설정
      request.httpBody = body
    }
    
    return request
  }
}
