//
//  PhotosViewController+CollectionViewExtension.swift
//  neighborhoodmap
//
//  Created by Phuc Tran on 4/12/18.
//  Copyright © 2018 Phuc Tran. All rights reserved.
//
import  UIKit
import CoreData

extension PhotosViewController:  UICollectionViewDataSource, UICollectionViewDelegate{
    
    func setupCollectionView() {
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let sectionInfo = self.fetchedResultsController.sections?[section] {
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celldentifier = "PhotoCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: celldentifier, for: indexPath) as! PhotoCell
        cell.imageView.image = nil
        cell.activityIndicator.startAnimating()
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView.cellForItem(at: indexPath) == nil {
            return
        }
        
        let photo = fetchedResultsController.object(at: indexPath)
        if let imageUrl = photo.imageUrl {
            FileDownloader.shared.cancelDownload(imageUrl)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let photo = fetchedResultsController.object(at: indexPath)
        let photoViewCell = cell as! PhotoCell
        photoViewCell.imageUrl = photo.imageUrl!
        downloadImage(using: photoViewCell, photo: photo, collectionView: collectionView, index: indexPath)

    }
    
    func downloadImage(using cell: PhotoCell, photo: Photo, collectionView: UICollectionView, index: IndexPath) {
        if let imageData = photo.image {
            cell.activityIndicator.stopAnimating()
            cell.imageView.image = UIImage(data: Data(referencing: imageData))
        } else {
            if let imageUrl = photo.imageUrl {
                cell.activityIndicator.startAnimating()
                FileDownloader.shared.downloadImage(imageUrl: imageUrl) { (data, error) in
                    
                    
                    if let _ = error {
                        cell.activityIndicator.stopAnimating()
                        return
                    } else if let data = data {
                        if let currentCell = collectionView.cellForItem(at: index) as? PhotoCell {
                            if currentCell.imageUrl == imageUrl {
                                currentCell.imageView.image = UIImage(data: data)
                                cell.activityIndicator.stopAnimating()
                            }
                            
                            photo.image = NSData(data: data)
                            DataController.shared.saveContext()
                        }
                        
                    }
                }
            }
        }
        
    }
}
