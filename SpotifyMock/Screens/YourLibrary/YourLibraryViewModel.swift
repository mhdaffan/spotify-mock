//
//  YourLibraryViewModel.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 07/12/24.
//

import Combine

final class YourLibraryViewModel: ViewModel {
  
  // MARK: Injected
  
  @Injected(\.searchUseCase) var searchUseCase: SearchUseCase
  @Injected(\.databaseUseCase) var databaseUseCase: DatabaseUseCase
  
  // MARK: - Observables
  
  @Published var musics: [TrackModel] = []
  @Published var playlistsDataSource: [PlaylistDataSource] = []
  @Published var collectionSection: CollectionSectionDataSrouce = .list
  
  func toggleLibrarySection() {
    collectionSection = collectionSection == .grid ? .list : .grid
  }
  
  func getPlaylists() {
    playlistsDataSource = databaseUseCase.getPlaylists().toDataSource()
  }
}
