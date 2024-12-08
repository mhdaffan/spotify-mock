//
//  SearchTabViewModel.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 08/12/24.
//

import Foundation
import Combine

final class SearchTabViewModel: ViewModel {
  
  // MARK: Injected
  
  @Injected(\.searchUseCase) var searchUseCase: SearchUseCase
  
  // MARK: - Observables
  
  @Published var tracksDataSource: [TrackDataSource] = []
  @Published var searchKeyword: String = ""
  
  func getTracks(for artist: String) {
    isLoading = true
    searchUseCase.getTracks(for: artist)
      .sinkOnMainThread(
        onReceiveValue: { [weak self] response in
          self?.isLoading = false
          self?.tracksDataSource = response.toDataSource()
        },
        onFailed: { [weak self] error in
          self?.isLoading = false
          print(error.localizedDescription)
        },
        storeIn: &cancellables
      )
  }
}
