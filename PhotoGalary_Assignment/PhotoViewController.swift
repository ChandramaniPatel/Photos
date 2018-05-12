//
//  PhotoViewController.swift
//  PhotoGalary_Assignment
//
//  Created by sumo on 12/05/18.
//  Copyright © 2018 sumo. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    var photos: [Photo]?
    let cellIdentifier = "detailPhotoCell"
    var selectedIndexPath = IndexPath(item: 0, section: 0)
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
          self.collectionView.scrollToItem(at: selectedIndexPath, at: .centeredHorizontally, animated: true)
        }
}
    // MARK: - UICollectionView delegate/data source
    
extension PhotoViewController : UICollectionViewDataSource,UICollectionViewDelegate {
      func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let photos = photos else { return 1 }
        return photos.count
    }
    
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: UICollectionViewCell
            let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath as IndexPath) as! DetailCollectionViewCell
        photoCell.setImageToCell(photoUrl:photos![indexPath.item].photoUrl)
            cell = photoCell
          return cell
    }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
            return CGSize(width: self.collectionView.frame.size.width, height: self.collectionView.frame.size.height)
        }
}






