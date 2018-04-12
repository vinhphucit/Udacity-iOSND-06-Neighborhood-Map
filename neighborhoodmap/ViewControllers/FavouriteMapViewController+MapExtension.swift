//
//  FavouriteMapViewController+MapExtension.swift
//  neighborhoodmap
//
//  Created by Phuc Tran on 4/12/18.
//  Copyright © 2018 Phuc Tran. All rights reserved.
//

import Foundation

import Foundation
import MapKit
extension FavouriteMapViewController: MKMapViewDelegate {
    
    func setupMap() {
        mkMapView.delegate = self
        showPinsOnMap()
    }
    func showPinsOnMap() {
        mkMapView.removeAnnotations(mkMapView.annotations)
        
        let annotation = MKPointAnnotation()
        let lat = Double((venue?.lat)!)
        let lon = Double((venue?.lng)!)
        annotation.coordinate = CLLocationCoordinate2DMake(lat!, lon!)
        annotation.title = venue?.name
        if let address = venue?.address {
            annotation.subtitle = address
        }
        
        mkMapView.addAnnotation(annotation)
        
        let center = CLLocationCoordinate2D(latitude: lat!, longitude: lon!)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mkMapView.setRegion(region, animated: true)
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.animatesDrop = false
        } else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
}

