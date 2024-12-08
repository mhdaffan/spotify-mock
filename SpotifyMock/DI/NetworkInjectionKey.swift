//
//  NetworkInjectionKey.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 06/12/24.
//

import Foundation

struct NetworkServiceInjectionKey: InjectionKey {
  static var currentValue: NetworkService = NetworkServiceImpl()
}

struct SessionServiceInjectionKey: InjectionKey {
  static var currentValue: SessionService = SessionServiceImpl()
}

struct NetworkConfigurationInjectionKey: InjectionKey {
  static var currentValue: NetworkConfiguration = NetworkConfigurationImpl(
    baseURL: "https://itunes.apple.com",
    headers: [
      "Content-Type": "application/json"
    ]
  )
}

extension InjectedValue {
  var networkConfiguration: NetworkConfiguration {
    get { Self[NetworkConfigurationInjectionKey.self] }
    set { Self[NetworkConfigurationInjectionKey.self] = newValue }
  }
  
  var networkService: NetworkService {
    get { Self[NetworkServiceInjectionKey.self] }
    set { Self[NetworkServiceInjectionKey.self] = newValue }
  }
  
  var sessionService: SessionService {
    get { Self[SessionServiceInjectionKey.self] }
    set { Self[SessionServiceInjectionKey.self] = newValue }
  }
}
