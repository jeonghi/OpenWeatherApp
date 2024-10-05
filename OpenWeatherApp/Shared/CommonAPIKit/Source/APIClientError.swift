//
//  APIClientError.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/1/24.
//

import Foundation

enum APIClientError: Error {
  case invalidURL
  case invalidResponse
  case decodingError
  case custom(APIClientErrorType)
}

extension APIClientError: LocalizedError {
  
  var errorDescription: String? {
    switch self {
    case .custom(let error):
      return error.localizedDescription
    default:
      return localizedDescription
    }
  }
}

typealias APIClientErrorType = Error & Decodable
