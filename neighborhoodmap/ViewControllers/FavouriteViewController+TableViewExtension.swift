//
//  FavouriteViewController+TableViewExtension.swift
//  neighborhoodmap
//
//  Created by Phuc Tran on 4/12/18.
//  Copyright © 2018 Phuc Tran. All rights reserved.
//

import UIKit
import CoreData
extension FavouriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sectionInfo = self.fetchedResultsController.sections?[section] {
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellReuseIdentifier = "FavouriteCell"
        let favourite = fetchedResultsController.object(at: indexPath)
        let cell = tvFavourite.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! FavouriteCell!
        
        /* Set cell defaults */
        cell?.lblName!.text = "Name: \(favourite.name!)"
        cell?.lblAddress!.text = "Address: \(favourite.address!)"
        
        return cell!
    }
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favouriteItem = fetchedResultsController.object(at: indexPath)
        performSegue(withIdentifier: "goToFavouritePhotoSegue", sender: favouriteItem)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func setupFetchedResultController() {
        
        let fr = NSFetchRequest<Favourite>(entityName: "Favourite")
        fr.sortDescriptors = []
        // Create the FetchedResultsController
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: DataController.shared.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        // Start the fetched results controller
        var error: NSError?
        do {
            try fetchedResultsController.performFetch()
        } catch let error1 as NSError {
            error = error1
        }
        
        if let error = error {
            print("\(#function) Error performing initial fetch: \(error)")
        }
    }

    
}
