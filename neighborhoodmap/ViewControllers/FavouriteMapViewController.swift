//
//  FavouriteMapViewController.swift
//  neighborhoodmap
//
//  Created by Phuc Tran on 4/11/18.
//  Copyright © 2018 Phuc Tran. All rights reserved.
//

import UIKit
import MapKit
class FavouriteMapViewController: UIViewController {
    @IBOutlet weak var mkMapView: MKMapView!
    
    @IBOutlet weak var navigation: UINavigationItem!
    
    
    var venue: Favourite?
    override func viewDidLoad() {
        super.viewDidLoad()
       setupMap()
        navigation.title = venue?.name
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


