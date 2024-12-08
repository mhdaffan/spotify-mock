//
//  PlaylistModel.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 08/12/24.
//

import RealmSwift

struct PlaylistModel {
  let id: Int
  let name: String
  var tracks: [TrackModel]
}

extension PlaylistModel {
  func toDataSource() -> PlaylistDataSource {
    return PlaylistDataSource(
      id: id,
      name: name,
      tracks: tracks.toDataSource()
    )
  }
  
  func toDatabaseModel() -> PlaylistDatabaseModel {
    let databaseModel = PlaylistDatabaseModel()
    
    let trackList = List<TrackDatabaseModel>()
    tracks.forEach { track in
      trackList.append(track.toDatabaseModel())
    }
    
    databaseModel.id = id
    databaseModel.name = name
    databaseModel.tracks = trackList
    
    return databaseModel
  }
}

extension Array where Element == PlaylistModel {
  func toDataSource() -> [PlaylistDataSource] {
    return self.map { $0.toDataSource() }
  }
}
