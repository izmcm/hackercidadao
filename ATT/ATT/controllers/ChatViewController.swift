//
//  ChatViewController.swift
//  ATT
//
//  Created by vinicius emanuel on 04/10/19.
//  Copyright © 2019 hackercidadao. All rights reserved.
//

import UIKit
import CoreLocation

class ChatViewController: UIViewController {
    
    var img: UIImage?
    var location: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let location = self.location else{ return }
        self.fetchLocationFrom(location: location)
    }
    
    func fetchLocationFrom(location: CLLocation){
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            if error == nil{
                let mark = placemarks?.first
                
                print("cidade:",mark?.locality)
                print("bairro:",mark?.subLocality)
                print("rua:",mark?.thoroughfare)
                print("número:",mark?.subThoroughfare)
                
                FirebaseHelper.share.sendAdress(cidade: mark?.locality ?? "", bairro: mark?.subLocality ?? "", rua: mark?.thoroughfare ?? "", numero: mark?.subThoroughfare ?? "")
                
            }
        }
    }

}
