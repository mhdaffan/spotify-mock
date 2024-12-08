//
//  Endpoint.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 06/12/24.
//

import Foundation

class Endpoint<T>: Requestable {
  let path: String
  let isFullPath: Bool
  let useBaseResponse: Bool
  let method: HTTPMethod
  let queryParameters: [String: Any]
  let headerParamaters: [String: String]
  let bodyParamaters: [String : Any]
  
  init(path: String,
       isFullPath: Bool = false,
       useBaseResponse: Bool = true,
       method: HTTPMethod = .get,
       queryParameters: [String: Any] = [:],
       headerParamaters: [String: String] = [:],
       bodyParamaters: [String : Any] = [:]
  ) {
    self.path = path
    self.isFullPath = isFullPath
    self.useBaseResponse = useBaseResponse
    self.method = method
    self.queryParameters = queryParameters
    self.headerParamaters = headerParamaters
    self.bodyParamaters = bodyParamaters
  }
}
