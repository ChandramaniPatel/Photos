//
//  Photo+Services1.swift
//  PhotoGalary_Assignment
//
//  Created by sumo on 09/05/18.
//  Copyright © 2018 sumo. All rights reserved.
//


import Foundation

enum PhotoServiceError: String, Error {
  case NotImplemented = "This feature has not been implemented yet"
  case URLParsing = "Sorry, there was an error getting the photos"
  case JSONStructure = "Sorry, the photo service returned something different than expected"
}

typealias PhotosResult = ([Photo]?, Error?) -> Void

extension Photo {
    class func getAllFeedPhotos(completion: @escaping PhotosResult) {
    guard let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1") else {
      completion(nil, PhotoServiceError.URLParsing)
      return
    }

    NetworkClient.sharedInstance.getURL(url: url) { (result, error) in
      guard error == nil else {
        completion(nil, error)
        return
      }
        if let dictionary = result as? NSDictionary, let items = dictionary["items"] as? [NSDictionary] {
        var photos = [Photo]()
        for item in items {
          photos.append(Photo(dictionary: item))
        }
        completion(photos, nil)
      } else {
        completion(nil, PhotoServiceError.JSONStructure)
      }
    }
  }
}
