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
                
            }
        }
    }
}

extension ChatViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return ChatHelper.shared.chat.count
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            if ChatHelper.shared.chat[indexPath.row].type == .Server{
                let cell = tableView.dequeueReusableCell(withIdentifier: "SistemCell") as! TextMessageTableViewCell
                
                return cell
            }else if ChatHelper.shared.chat[indexPath.row].type == .User{
                let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! TextMessageTableViewCell
                
                return cell
            }
        }else{
            let cell = UITableViewCell()
            cell.backgroundColor = .red
            return cell
        }
        
        return UITableViewCell()
    }
}
