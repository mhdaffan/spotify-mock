//
//  PlaylistDataSource.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 08/12/24.
//

struct PlaylistDataSource: Hashable {
  let id: Int
  let name: String
  var tracks: [TrackDataSource]
}

extension PlaylistDataSource {
  func toDomain() -> PlaylistModel {
    return PlaylistModel(
      id: id,
      name: name,
      tracks: tracks.map { $0.toDomain() })
  }
  
  func thumbnail() -> LibraryThumbnailType {
    if tracks.count >= 4 {
      return .multiple(
        url1: tracks[0].artworkUrl100,
        url2: tracks[1].artworkUrl100,
        url3: tracks[2].artworkUrl100,
        url4: tracks[3].artworkUrl100
      )
    } else if let firstTrack = tracks.first {
      return .single(url: firstTrack.artworkUrl100)
    } else {
      return .placeholder
    }
  }
}
