//
//  RepositoryInjectionKey.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 07/12/24.
//

struct SearchRepositoryInjectionKey: InjectionKey {
  static var currentValue: SearchRepository = SearchRepositoryImpl()
}

struct DatabaseRepositoryInjectionKey: InjectionKey {
  static var currentValue: DatabaseRepository = DatabaseRepositoryImpl()
}

extension InjectedValue {
  var searchRepository: SearchRepository {
    get { Self[SearchRepositoryInjectionKey.self] }
    set { Self[SearchRepositoryInjectionKey.self] = newValue }
  }
  
  var databaseRepository: DatabaseRepository {
    get { Self[DatabaseRepositoryInjectionKey.self] }
    set { Self[DatabaseRepositoryInjectionKey.self] = newValue }
  }
}
