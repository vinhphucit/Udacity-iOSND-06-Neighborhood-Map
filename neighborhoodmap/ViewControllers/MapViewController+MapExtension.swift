//
//  MapViewController+MapExtension.swift
//  neighborhoodmap
//
//  Created by Phuc Tran on 4/11/18.
//  Copyright © 2018 Phuc Tran. All rights reserved.
//

import Foundation
import MapKit
extension MapViewController: MKMapViewDelegate {
    
    func setupMap() {
        mkMapView.delegate = self
        
        if let region = MapUserDefault.shared.getMapRegion() {
            mkMapView.setRegion(region, animated: true)
        }else {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
            if CLLocationManager.locationServicesEnabled() {
                locationManager.requestWhenInUseAuthorization()
                locationManager.startUpdatingLocation()
            }
        }
        
        if let lastRequestRestaurant = MapUserDefault.shared.getLastRequestRestaurant() {
            let photoObject = try? JSONDecoder().decode(RestaurantParser.self, from: lastRequestRestaurant.data(using: .utf8)!)
            if let photoObject = photoObject {
                showPinsOnMap(pins: (photoObject.response?.venues)!)
            }
        }
    }
    func showPinsOnMap(pins: [Venue]) {
        mkMapView.removeAnnotations(mkMapView.annotations)
        for pin in pins  {
            let annotation = MKPointAnnotation()
            let lat = Double((pin.location?.lat)!)
            let lon = Double((pin.location?.lng)!)
            annotation.coordinate = CLLocationCoordinate2DMake(lat, lon)
            annotation.title = pin.name
            if let address = pin.location?.address {
                    annotation.subtitle = address
            }
            
            mkMapView.addAnnotation(annotation)
            data["\(lat),\(lon)"] = pin
        }
    }
    func mapViewRegionDidChangeFromUserInteraction() -> Bool {
        let view = self.mkMapView.subviews[0]
        //  Look through gesture recognizers to determine whether this region change is from user interaction
        if let gestureRecognizers = view.gestureRecognizers {
            for recognizer in gestureRecognizers {
                if( recognizer.state == UIGestureRecognizerState.began || recognizer.state == UIGestureRecognizerState.ended ) {
                    return true
                }
            }
        }
        return false
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.animatesDrop = true
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let link = view.annotation?.subtitle  {
           performSegue(withIdentifier: "showRestaurantDetailSegue", sender: view.annotation)
            
        }
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        mapChangedFromUserInteraction = mapViewRegionDidChangeFromUserInteraction()
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if (mapChangedFromUserInteraction) {
            print("New Region \(mkMapView.region)")
            MapUserDefault.shared.saveRegion(mapRegion: mkMapView.region)
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last as! CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mkMapView.setRegion(region, animated: true)
        
        locationManager.delegate = nil
        locationManager.stopUpdatingLocation()

    }
}

extension MKMapView {
    
    func topCenterCoordinate() -> CLLocationCoordinate2D {
        return self.convert(CGPoint(x: self.frame.size.width / 2.0, y: 0), toCoordinateFrom: self)
    }
    
    func currentRadius() -> Double {
        let centerLocation = CLLocation(latitude: self.centerCoordinate.latitude, longitude: self.centerCoordinate.longitude)
        let topCenterCoordinate = self.topCenterCoordinate()
        let topCenterLocation = CLLocation(latitude: topCenterCoordinate.latitude, longitude: topCenterCoordinate.longitude)
        return centerLocation.distance(from: topCenterLocation)
    }
    
}
