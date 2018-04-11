//
//  RestaurantParser.swift
//  neighborhoodmap
//
//  Created by Phuc Tran on 4/11/18.
//  Copyright © 2018 Phuc Tran. All rights reserved.
//

import Foundation

struct RestaurantParser: Codable {
    let response: ResponseRestaurant?
}

struct ResponseRestaurant: Codable {
    let venues: [Venue]?
}

struct Venue: Codable {
    let id: String?
    let name: String?
    let contact: Contact?
    let url: String?
    let location: Location?
}

struct Contact: Codable {
    let phone: String?
    let formattedPhone: String?
}

struct Location: Codable {
    let address: String?
    let lat: Double
    let lng: Double
    let formattedAddress: [String]

}
