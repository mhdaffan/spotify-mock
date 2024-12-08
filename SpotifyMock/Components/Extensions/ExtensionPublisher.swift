//
//  ExtensionPublisher.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 07/12/24.
//

import Foundation
import Combine

extension Publisher {
  func receiveOnMainThread() -> Publishers.ReceiveOn<Self, RunLoop> {
    self.receive(on: RunLoop.main)
  }
  
  func debounceOnMainThread(
    for duration: RunLoop.SchedulerTimeType.Stride = .milliseconds(300)
  ) -> Publishers.Debounce<Self, RunLoop> {
    self.debounce(for: duration, scheduler: RunLoop.main)
  }
  
  func sinkToResult(
    onReceiveValue: ((Output) -> Void)? = nil,
    onFailure: ((Error) -> Void)? = nil,
    storeIn cancellables: inout Set<AnyCancellable>
  ) {
    self.sink(
      receiveCompletion: { result in
        switch result {
        case .finished:
          break
        case .failure(let error):
          onFailure?(error)
        }
      },
      receiveValue: { output in
        onReceiveValue?(output)
      }
    )
    .store(in: &cancellables)
  }
  
  func sinkOnMainThread(
    onReceiveValue: @escaping (Output) -> Void,
    onFailed: ((Error) -> Void)? = nil,
    storeIn cancellables: inout Set<AnyCancellable>
  ) {
    self.receiveOnMainThread()
      .sinkToResult(
        onReceiveValue: onReceiveValue,
        onFailure: { error in
          onFailed?(error)
        },
        storeIn: &cancellables
      )
  }
}

// MARK: - Static

extension Publisher {
  static func mockSuccess<T>(value: T) -> AnyPublisher<T, Error> {
    Just(value)
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()
  }
  
  static func mockFailure<T>(_ error: Error) -> AnyPublisher<T, Error> {
    Fail(error: error)
      .eraseToAnyPublisher()
  }
}
