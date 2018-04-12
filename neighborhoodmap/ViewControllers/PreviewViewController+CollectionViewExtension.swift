//
//  PreviewViewController+CollectionViewExtension.swift
//  neighborhoodmap
//
//  Created by Phuc Tran on 4/12/18.
//  Copyright © 2018 Phuc Tran. All rights reserved.
//

import UIKit

extension PreviewViewController:  UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
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
        
        let photo = photos[indexPath.row]
        if let prefix = photo.photo?.prefix, let suffix = photo.photo?.suffix {
            let imageUrl = "\(prefix)300x300\(suffix)"
            FileDownloader.shared.cancelDownload(imageUrl)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        let photoViewCell = cell as! PhotoCell
        if let prefix = photo.photo?.prefix, let suffix = photo.photo?.suffix {
            let imageUrl = "\(prefix)300x300\(suffix)"
            photoViewCell.imageUrl = imageUrl
        }
        downloadImage(using: photoViewCell, photo: photo, collectionView: collectionView, index: indexPath)
    }
    
    //    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    //        let photo = photos[indexPath.row]
    //         let photoViewCell = cell as! PhotoCell
    //        if let prefix = photo.photo?.prefix, let suffix = photo.photo?.suffix {
    //            let imageUrl = "\(prefix)300x300\(suffix)"
    //            photoViewCell.imageUrl = imageUrl
    //        }
    //        downloadImage(using: photoViewCell, photo: photo, collectionView: collectionView, index: indexPath)
    //    }
    //    func collectionView(_ collectionView: UICollectionView, didEndDisplaying: UICollectionViewCell, forItemAt: IndexPath) {
    //
    //        if collectionView.cellForItem(at: forItemAt) == nil {
    //            return
    //        }
    //
    //        let photo = photos[forItemAt.row]
    //        if let prefix = photo.photo?.prefix, let suffix = photo.photo?.suffix {
    //            let imageUrl = "\(prefix)300x300\(suffix)"
    //            FileDownloader.shared.cancelDownload(imageUrl)
    //        }
    //
    //    }
    func downloadImage(using cell: PhotoCell, photo: PhotoImage, collectionView: UICollectionView, index: IndexPath) {
        if let imageData = photo.image {
            cell.activityIndicator.stopAnimating()
            cell.imageView.image = UIImage(data: Data(referencing: imageData))
        } else {
            if let prefix = photo.photo?.prefix, let suffix = photo.photo?.suffix {
                let imageUrl = "\(prefix)300x300\(suffix)"
                cell.activityIndicator.startAnimating()
                FileDownloader.shared.downloadImage(imageUrl: imageUrl) { (data, error) in
                    self.numberDownloaded=self.numberDownloaded+1;
                    print(self.numberDownloaded)
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
                            
                        }
                        
                    }
                }
            }
        }
        
    }
}
