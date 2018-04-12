//
//  FavouriteViewController.swift
//  neighborhoodmap
//
//  Created by Phuc Tran on 4/11/18.
//  Copyright © 2018 Phuc Tran. All rights reserved.
//

import UIKit
import CoreData
class FavouriteViewController: UIViewController {
    @IBOutlet weak var tvFavourite: UITableView!
    var selectedIndexes = [IndexPath]()
    var insertedIndexPaths: [IndexPath]!
    var deletedIndexPaths: [IndexPath]!
    var updatedIndexPaths: [IndexPath]!
    var fetchedResultsController: NSFetchedResultsController<Favourite>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFetchedResultController()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFavouritePhotoSegue" {
            let sender = sender as? Favourite
            if let venue = sender {
                let secondViewController = segue.destination as! PhotosViewController
                secondViewController.venue = venue
            }
            
        }
    }
}


