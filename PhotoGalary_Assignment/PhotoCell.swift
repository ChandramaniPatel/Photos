//
//  PhotoCell.swift
//  PhotoGalary_Assignment
//
//  Created by sumo on 09/05/18.
//  Copyright © 2018 sumo. All rights reserved.
//


import UIKit

class PhotoCell: UICollectionViewCell {
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var progressView: UIProgressView!
  
  var imageTask: URLSessionDownloadTask?

  var photo: Photo? {
    didSet {
      imageTask?.cancel()
      guard let photoUrl = photo?.photoUrl else {
        self.photoImageView.image = UIImage(named: "Downloading")
        return
      }
        imageTask = NetworkClient.sharedInstance.getImageInBackground(url: photoUrl,
        downloadProgressBlock: { [weak self] (progress) in
          if (progress > 0 && progress < 1) {
            self?.progressView.progress = progress
            self?.progressView.isHidden = false
          } else {
            self?.progressView.isHidden = true
          }
        }, completion: { [weak self] (image, error) in
          guard error == nil else {
            self?.photoImageView.image = UIImage(named: "Broken")
            return
          }
          self?.photoImageView.image = image
        })
    }
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    photo = nil
  }
}
