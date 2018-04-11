//
//  ViewController.swift
//  neighborhoodmap
//
//  Created by Phuc Tran on 4/11/18.
//  Copyright © 2018 Phuc Tran. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet weak var mkMapView: MKMapView!
    @IBOutlet weak var btnRefresh: UIBarButtonItem!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var mapChangedFromUserInteraction = false
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation?
    var data = [String:Venue]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        loadingIndicator.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onClickRefreshButton(_ sender: Any) {
        print(mkMapView.centerCoordinate)
        
        let centerLatitude = mkMapView.centerCoordinate.latitude
        let centerLongitude = mkMapView.centerCoordinate.longitude
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
        NetworkClient.shared.doSearchRestaurants(latitude: centerLatitude, longitude: centerLongitude, currentRadius: mkMapView.currentRadius()) { (data, error) in
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.isHidden = true
            if error != nil {
                self.presentAlert(title: "Error", message: error!) { (alert) in
                    
                }
            }else {
                
                let productJSON = try? JSONEncoder().encode(data)
                let json = String(data: productJSON!, encoding: String.Encoding.utf8)

                MapUserDefault.shared.saveLastRequestRestaurant(restaurant: json!)
                if let pins = data?.response?.venues, pins.count>0 {
                    self.showPinsOnMap(pins: pins)
                }else {
                    self.presentAlert(title: "No Restaurant Found", message: "") { (alert) in
                        
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRestaurantDetailSegue" {
            let sender = sender as! MKAnnotation
            if let venue = data["\(sender.coordinate.latitude),\(sender.coordinate.longitude)"] {
                let secondViewController = segue.destination as! PreviewViewController
                secondViewController.venue = venue
                
            }
            
        }
    }
}

