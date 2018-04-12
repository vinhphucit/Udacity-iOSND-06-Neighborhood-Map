//
//  Favourite+CoreDataProperties.swift
//  neighborhoodmap
//
//  Created by Phuc Tran on 4/12/18.
//  Copyright © 2018 Phuc Tran. All rights reserved.
//

import Foundation
import CoreData
extension Favourite {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favourite> {
        return NSFetchRequest<Favourite>(entityName: "Favourite")
    }
    
    @NSManaged public var id: String?
    @NSManaged public var lat: String
    @NSManaged public var lng: String
    @NSManaged public var address: String?
    @NSManaged public var contact: String?
    @NSManaged public var name: String?
    @NSManaged public var url: String?
    @NSManaged public var photos: NSSet?
    
}

// MARK: Generated accessors for photos
extension Favourite {
    
    @objc(addPhotosObject:)
    @NSManaged public func addToPhotos(_ value: Photo)
    
    @objc(removePhotosObject:)
    @NSManaged public func removeFromPhotos(_ value: Photo)
    
    @objc(addPhotos:)
    @NSManaged public func addToPhotos(_ values: NSSet)
    
    @objc(removePhotos:)
    @NSManaged public func removeFromPhotos(_ values: NSSet)
    
}
