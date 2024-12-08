//
//  DatabaseRepository.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 08/12/24.
//

import RealmSwift

protocol DatabaseRepository {
  func add<T: Object>(_ object: T)
  func get<T: Object>(_ objectType: T.Type) -> Results<T>
  func getObject<T: Object>(_ objectType: T.Type, primaryKey: Any) -> T?
  func delete<T: Object>(_ object: T)
  func deleteAll<T: Object>(_ objectType: T.Type)
}

class DatabaseRepositoryImpl: DatabaseRepository {
  
  private var realm: Realm {
    do {
      return try Realm()
    } catch {
      fatalError("Failed to initialize Realm: \(error.localizedDescription)")
    }
  }
  
  func add<T: Object>(_ object: T) {
    try? realm.write {
      realm.add(object, update: .all)
    }
    realm.refresh()
  }
  
  func get<T: Object>(_ objectType: T.Type) -> Results<T> {
    return realm.objects(objectType)
  }
  
  func getObject<T: Object>(_ objectType: T.Type, primaryKey: Any) -> T? {
    return realm.object(ofType: objectType, forPrimaryKey: primaryKey)
  }
  
  func delete<T: Object>(_ object: T) {
    try? realm.write {
      realm.delete(object)
    }
    realm.refresh()
  }
  
  func deleteAll<T: Object>(_ objectType: T.Type) {
    let objects = realm.objects(objectType)
    try? realm.write {
      realm.delete(objects)
    }
    realm.refresh()
  }
}
