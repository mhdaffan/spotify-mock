//
//  UseCaseInjectionKey.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 07/12/24.
//

struct SearchUseCaseInjectionKey: InjectionKey {
  static var currentValue: SearchUseCase = SearchUseCaseImpl()
}

struct DatabaseUseCaseInjectionKey: InjectionKey {
  static var currentValue: DatabaseUseCase = DatabaseUseCaseImpl()
}

extension InjectedValue {
  var searchUseCase: SearchUseCase {
    get { Self[SearchUseCaseInjectionKey.self] }
    set { Self[SearchUseCaseInjectionKey.self] = newValue }
  }
  
  var databaseUseCase: DatabaseUseCase {
    get { Self[DatabaseUseCaseInjectionKey.self] }
    set { Self[DatabaseUseCaseInjectionKey.self] = newValue }
  }
}
