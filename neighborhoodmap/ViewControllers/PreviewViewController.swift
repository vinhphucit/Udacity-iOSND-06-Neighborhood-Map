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
   
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblContact: UILabel!
    @IBOutlet weak var lblUrl: UILabel!
    
    var venue: Venue?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onClickAddButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupView(){
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


