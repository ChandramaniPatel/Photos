//
//  Photo.swift
//  PhotoGalary_Assignment
//
//  Created by sumo on 09/05/18.
//  Copyright © 2018 sumo. All rights reserved.
//

import Foundation

class Photo: NSObject {
  var itemId: String
  var photoUrl: URL
  var favorite = false

  static let itemIdKey = "itemId"
  static let photoUrlKey = "photoUrl"
  static let favoriteKey = "favorite"

  init(dictionary values: NSDictionary) {
    guard let link = values["link"] as? String else {
      fatalError("Photo item could not be created: " + values.description)
    }
    itemId = link

    guard let media = values["media"] as? NSDictionary,
        let urlString = media["m"] as? String, let url = URL(string: urlString) else {
      fatalError("Photo item could not be created: " + values.description)
    }
    photoUrl = url
  }

  // MARK: NSCoder methods

  @objc required init?(coder aDecoder: NSCoder) {
    guard let decodedItemId = aDecoder.decodeObject(forKey: Photo.itemIdKey) as? String,
        let decodedPhotoUrl = aDecoder.decodeObject(forKey: Photo.photoUrlKey) as? URL else {
        fatalError("Photo item could not be created")
    }
    itemId = decodedItemId
    photoUrl = decodedPhotoUrl
    favorite = aDecoder.decodeBool(forKey: Photo.favoriteKey)
  }

  @objc func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encode(itemId, forKey: Photo.itemIdKey)
    aCoder.encode(photoUrl, forKey: Photo.photoUrlKey)
    aCoder.encode(favorite, forKey: Photo.favoriteKey)
  }
}

// MARK: Equatable

func == (lhs: Photo, rhs: Photo) -> Bool {
  return lhs.itemId == rhs.itemId
}
