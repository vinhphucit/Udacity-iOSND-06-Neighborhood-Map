//
//  PreviewViewController.swift
//  neighborhoodmap
//
//  Created by Phuc Tran on 4/11/18.
//  Copyright © 2018 Phuc Tran. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {
    
    @IBOutlet weak var navigation: UINavigationItem!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblContact: UILabel!
    @IBOutlet weak var lblUrl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var photos: [PhotoImage] = []
    var numberDownloaded:Int = 0;
    
    var venue: Venue?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchPhotoFromFourSquare()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onClickAddButton(_ sender: Any) {
        let pin: Favourite = Favourite(context: DataController.shared.viewContext)
        
        pin.lat = "\((venue?.location?.lat)!)"
        pin.lng = "\((venue?.location?.lng)!)"
        
        if let address = venue?.location?.address{
                pin.address = address
        }
        if let formattedPhone = venue?.contact?.formattedPhone{
            pin.contact = formattedPhone
        }
        
        pin.id = venue?.id!
        pin.name = venue?.name!
        
        if let url = venue?.url{
            pin.url = url
        }
        
        
        DataController.shared.saveContext()
        
        
        navigationController?.popViewController(animated: true)
    }
    private func fetchPhotoFromFourSquare() {
        if let venue = venue {
            self.numberDownloaded = 0
            NetworkClient.shared.doGetPhotos(venueid: venue.id!, completion: { (data, error) in
                if error != nil {
                    self.presentAlert(title: "Error", message: error!) { (alert) in
                        
                    }
                }else {
                    
                    if let pins = data?.response.photos?.items, pins.count>0 {
                        for pin in pins {
                            self.photos.append(PhotoImage(photo: pin))
                        }
                        
                        self.collectionView.reloadData()
                    }else {
                        self.presentAlert(title: "No Photo Found", message: "") { (alert) in
                            
                        }
                    }
                }
            })
        }
    }
    private func setupView(){
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
        lblAddress.numberOfLines = 3
        lblContact.numberOfLines = 3
        lblUrl.numberOfLines = 3
        if let venue = venue {
            navigation.title = venue.name!
            lblAddress.text = "Address: \(venue.location?.formattedAddress.flatMap({$0}).joined(separator: " ") ?? "")"
            
            if let contact = venue.contact, let phonenumber = contact.formattedPhone {
                lblContact.text = "Phone: \(phonenumber)"
            }else {
                lblContact.text = "Phone: N/A"
            }
            
            if let url = venue.url {
                lblUrl.text = "Website: \(url)"
            }else{
                lblUrl.text = "Website: N/A"
            }
        }
    }
}


