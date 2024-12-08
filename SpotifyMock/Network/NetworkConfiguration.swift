//
//  NetworkConfiguration.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 06/12/24.
//

import Foundation

protocol NetworkConfiguration {
  var baseURL: String { get }
  var headers: [String: String] { get set }
}

struct NetworkConfigurationImpl: NetworkConfiguration {
  let baseURL: String
  var headers: [String: String]
  
  init(baseURL: String, headers: [String: String] = [:]) {
    self.baseURL = baseURL
    self.headers = headers
  }
}
