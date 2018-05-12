
//
//  FeedViewController.swift
//  PhotoGalary_Assignment
//
//  Created by sumo on 09/05/18.
//  Copyright © 2018 sumo. All rights reserved.
//


import UIKit

class FeedViewController: UICollectionViewController {
    var photos: [Photo]?
    var currentMessage = "Loading photos..."
    let cellIdentifier = "photoCell"
    let messageCellIdentifier = "messageCell"
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Photos"
        Photo.getAllFeedPhotos { [weak self] (photos, error) in
            guard error == nil else {
                if let error = error as? PhotoServiceError {
                    self?.currentMessage = error.rawValue
                } else if let error = error {
                    self?.currentMessage = error.localizedDescription
                } else {
                    self?.currentMessage = "Sorry, there was an error."
                }
                self?.photos = nil
                self?.collectionView?.reloadData()
                return
            }
            self?.photos = photos
            self?.collectionView?.reloadData()
        }
    }
    
    // MARK: - UICollectionView delegate/data source
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let photos = photos else { return 1 }
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: UICollectionViewCell
        if let photos = photos, photos.count > 0 {
            let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath as IndexPath) as! PhotoCell
            photoCell.photo = photos[indexPath.item]
            cell = photoCell
        } else {
            let messageCell = collectionView.dequeueReusableCell(withReuseIdentifier: messageCellIdentifier, for: indexPath as IndexPath) as! MessageCell
            messageCell.messageLabel.text = currentMessage
            cell = messageCell
        }
        return cell
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard (photos?[indexPath.item]) != nil else { return }
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let photoViewController = storyboard.instantiateViewController(withIdentifier: "PhotoViewController") as! PhotoViewController
        photoViewController.photos = self.photos
        photoViewController.selectedIndexPath = indexPath
        self.navigationController?.pushViewController(photoViewController, animated: true)
    }
}
