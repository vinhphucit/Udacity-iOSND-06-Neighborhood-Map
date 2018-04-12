//
//  PhotosViewController.swift
//  neighborhoodmap
//
//  Created by Phuc Tran on 4/11/18.
//  Copyright © 2018 Phuc Tran. All rights reserved.
//

import UIKit
import CoreData
class PhotosViewController: UIViewController {
    @IBOutlet weak var navigation: UINavigationItem!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblContact: UILabel!
    @IBOutlet weak var lblUrl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    var fetchedResultsController: NSFetchedResultsController<Photo>!
    var venue: Favourite?
    var selectedIndexes = [IndexPath]()
    var insertedIndexPaths: [IndexPath]!
    var deletedIndexPaths: [IndexPath]!
    var updatedIndexPaths: [IndexPath]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
        setupFetchedResultController()
        if let photos = venue?.photos, photos.count == 0 {
            // pin selected has no photos
            fetchPhotoFromFourSquare()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func fetchPhotoFromFourSquare() {
        if let venue = venue {
            
            NetworkClient.shared.doGetPhotos(venueid: venue.id!, completion: { (data, error) in
                if error != nil {
                    self.presentAlert(title: "Error", message: error!) { (alert) in
                    }
                }else {
                    if let pins = data?.response.photos?.items, pins.count>0 {
                        for pin in pins {
                            let photoCD = Photo(context: DataController.shared.viewContext)
                            photoCD.favourite = self.venue
                            if let prefix = pin.prefix, let suffix = pin.suffix {
                                let imageUrl = "\(prefix)300x300\(suffix)"
                                photoCD.imageUrl = imageUrl
                            }
                            DataController.shared.saveContext()
                        }
                        
                    }else {
                        self.presentAlert(title: "No Photo Found", message: "") { (alert) in
                            
                        }
                    }
                }
            })
        }
    }
    private func setupView(){
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
        lblAddress.numberOfLines = 3
        lblContact.numberOfLines = 3
        lblUrl.numberOfLines = 3
        if let venue = venue {
            navigation.title = venue.name!
            lblAddress.text = "Address: \(venue.address!)"
            
            if let contact = venue.contact {
                lblContact.text = "Phone: \(contact)"
            }else {
                lblContact.text = "Phone: N/A"
            }
            
            if let url = venue.url {
                lblUrl.text = "Website: \(url)"
            }else{
                lblUrl.text = "Website: N/A"
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFavouriteMapSegue" {
            
            if let venue = venue {
                let secondViewController = segue.destination as! FavouriteMapViewController
                secondViewController.venue = venue
            }
            
        }
    }
}


