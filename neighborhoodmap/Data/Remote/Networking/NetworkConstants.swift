//
//  NetworkConstants.swift
//  neighborhoodmap
//
//  Created by Phuc Tran on 4/11/18.
//  Copyright © 2018 Phuc Tran. All rights reserved.
//

import Foundation

struct NetworkConstants {
    struct Flickr{
        static let APIScheme = "https"
        static let APIHost = "api.foursquare.com"
        static let APIPath = "/v2/venues"
    }
    struct FourSquareMethods {
        static let Search = "/search"
        static let Photos = "/photos"
    }
    
    struct FourSquareParamKeys {
        static let ClientId = "client_id"
        static let ClientSecret = "client_secret"
        static let CategoryId = "categoryId"
        static let Limit = "limit"
        static let Version = "v"
        static let latlng = "ll"
        static let radius = "radius"
    }
    
    struct FourSquareParamValues {
        static let ClientId = "ICK4GLHZJPJGAVAZD5CSQLU5UD1MJKY4NZ2VEJGI0VDAMUQ2"
        static let ClientSecret = "IT52JQ5CK2N0RCCNHJCGNZA2V34Z11ONVZ0VMWBLT3X14XBG"
        static let CategoryId = "4d4b7105d754a06374d81259"
        static let Limit = "30"
        static let Version = "20180411"
        static let radius = "2000"
    }
}

