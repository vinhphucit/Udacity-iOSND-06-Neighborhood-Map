//
//  PhotoImage.swift
//  neighborhoodmap
//
//  Created by Phuc Tran on 4/12/18.
//  Copyright © 2018 Phuc Tran. All rights reserved.
//

import Foundation

class PhotoImage {
    public var photo: Item?
    public var image: NSData?
    
    init(photo: Item) {
        self.photo = photo
        self.image = nil
    }

}
