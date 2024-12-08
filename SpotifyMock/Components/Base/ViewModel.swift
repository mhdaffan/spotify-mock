//
//  ViewModel.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 06/12/24.
//

import Combine

class ViewModel {
  
  var cancellables: Set<AnyCancellable> = []
  
  // MARK: - Obersables
  
  @Published var isLoading: Bool = false
  
  deinit {
    cancellables.removeAll()
  }
}
