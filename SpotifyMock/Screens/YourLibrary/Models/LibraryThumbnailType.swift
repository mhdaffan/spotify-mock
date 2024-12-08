//
//  LibraryThumbnailType.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 09/12/24.
//

enum LibraryThumbnailType {
  case placeholder
  case single(url: String)
  case multiple(url1: String, url2: String, url3: String, url4: String)
}
