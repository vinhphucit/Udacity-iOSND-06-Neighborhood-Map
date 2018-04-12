//
//  PhotoParser.swift
//  neighborhoodmap
//
//  Created by Phuc Tran on 4/11/18.
//  Copyright © 2018 Phuc Tran. All rights reserved.
//

import Foundation

struct PhotoParser: Codable {
    let response: ResponsePhoto
}

struct ResponsePhoto: Codable {
    let photos: PhotoItem?
}

struct PhotoItem: Codable {
    let count: Int?
    let items: [Item]
}

struct Item: Codable {
    let id: String?
    let prefix: String?
    let suffix: String?    
}
