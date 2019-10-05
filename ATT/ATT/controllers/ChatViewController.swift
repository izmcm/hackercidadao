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
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let location = self.location else{ return }
        
        guard let img = self.img else {return}
        
        FirebaseHelper.share.sendImage(image: img, block: {
            let newMessage = Message(type: .Server, text: "Pronto, recebi a sua foto!\n Você pode compartilhar a sua localização para que possamos atender as vítimas?")
            ChatHelper.shared.chat.append(newMessage)
            ChatHelper.shared.curentImputType = .Boolean
            self.tableView.reloadData()
        })
        
    }
    
    func fetchLocationFrom(location: CLLocation){
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            if error == nil{
                let mark = placemarks?.first
                
                print("cidade:",mark?.locality)
                print("bairro:",mark?.subLocality)
                print("rua:",mark?.thoroughfare)
                print("número:",mark?.subThoroughfare)
                
                FirebaseHelper.share.sendAdress(cidade: mark?.locality ?? "", bairro: mark?.subLocality ?? "", rua: mark?.thoroughfare ?? "", numero: mark?.subThoroughfare ?? "", block: {
                    let newMessage = Message(type: .Server, text: "Quantas vítimas o acidente possui?")
                    ChatHelper.shared.chat.append(newMessage)
                    ChatHelper.shared.curentImputType = .Selection
                    self.tableView.reloadData()
                })
            }
        }
    }
}

extension ChatViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if ChatHelper.shared.curentImputType != nil{
            return 2
        }else{
            return 1
        }
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
                
                cell.lblMessage.text = ChatHelper.shared.chat[indexPath.row].text
                
                return cell
            }else if ChatHelper.shared.chat[indexPath.row].type == .User{
                let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! TextMessageTableViewCell
                
                cell.lblMessage.text = ChatHelper.shared.chat[indexPath.row].text
                
                return cell
            }
        }else{
            switch ChatHelper.shared.curentImputType! {
            case .Boolean:
                let cell = tableView.dequeueReusableCell(withIdentifier: "buttonsCell") as! BooleanTableViewCell
                cell.delegate = self
                return cell
            case .Selection:
                let cell = tableView.dequeueReusableCell(withIdentifier: "segmentCell") as! SelectionTableViewCell
                cell.delegate = self
                return cell
            case .Slider:
                let cell = tableView.dequeueReusableCell(withIdentifier: "sliderCell") as! SliderTableViewCell
                return cell
            }
        }
        
        return UITableViewCell()
    }
}

extension ChatViewController: BooleanTableCellDelegate, SelectionCellDelegate {
    func tappedNumber(input: String) {
        print(input)
    }
    
    func tappedYes() {
        let newMessage = Message(type: .User, text: "Sim")
        ChatHelper.shared.chat.append(newMessage)
        self.fetchLocationFrom(location: location!)
    }
    
    
}
