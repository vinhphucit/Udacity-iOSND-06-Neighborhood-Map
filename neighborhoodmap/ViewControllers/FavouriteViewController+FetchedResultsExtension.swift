//
//  FavouriteViewController+FetchedResultsExtension.swift
//  neighborhoodmap
//
//  Created by Phuc Tran on 4/12/18.
//  Copyright © 2018 Phuc Tran. All rights reserved.
//

import UIKit
import CoreData

extension FavouriteViewController: NSFetchedResultsControllerDelegate{
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        insertedIndexPaths = [IndexPath]()
        deletedIndexPaths = [IndexPath]()
        updatedIndexPaths = [IndexPath]()
    }
    
    func controller(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>,
        didChange anObject: Any,
        at indexPath: IndexPath?,
        for type: NSFetchedResultsChangeType,
        newIndexPath: IndexPath?) {
        
        switch (type) {
        case .insert:
            insertedIndexPaths.append(newIndexPath!)
            break
        case .delete:
            deletedIndexPaths.append(indexPath!)
            break
        case .update:
            updatedIndexPaths.append(indexPath!)
            break
        case .move:
            print("Move an item. We don't expect to see this in this app.")
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tvFavourite.performBatchUpdates({() -> Void in
            
            for indexPath in self.insertedIndexPaths {
                self.tvFavourite.insertRows(at: [indexPath], with: .automatic)
            }
            
            for indexPath in self.deletedIndexPaths {
                self.tvFavourite.deleteRows(at: [indexPath], with: .automatic)
            }
            
            for indexPath in self.updatedIndexPaths {
                self.tvFavourite.reloadRows(at: [indexPath], with: .automatic)
            }
            
        }, completion: nil)
    }
}
