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
    var locationSended = false
    @IBOutlet weak var tableViewBottomConstrant: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let img = self.img else {return}
        
        FirebaseHelper.share.sendImage(image: img, block: {
            let newMessage = Message(type: .Server, text: "Pronto, recebi a sua foto!\n Você pode compartilhar a sua localização para que possamos atender as vítimas?")
            ChatHelper.shared.chat.append(newMessage)
            ChatHelper.shared.curentImputType = .Boolean
            self.tableView.reloadData()
        })
        
        self.configKeyboard()
    }
    
    func fetchLocationFrom(location: CLLocation){
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            if error == nil{
                let mark = placemarks?.first
                
                FirebaseHelper.share.sendAdress(cidade: mark?.locality ?? "", bairro: mark?.subLocality ?? "", rua: mark?.thoroughfare ?? "", numero: mark?.subThoroughfare ?? "", lat: self.location?.coordinate.latitude ?? 0, lon: self.location?.coordinate.longitude ?? 0, block: {
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
                cell.delegate = self
                return cell
            case .Comment:
                let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell") as! CommentTableViewCell
                cell.delegate = self
                cell.txtComment.resignFirstResponder()
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
        func configKeyboard() {
    
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(keyboardDidAppear),
                                                   name: UIResponder.keyboardWillShowNotification,
                                                   object: nil)
    
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(keyboardWillHide),
                                                   name: UIResponder.keyboardWillHideNotification,
                                                   object: nil)
    
            let tapToHideKeyboard = UITapGestureRecognizer(target: self,
                                                           action: #selector(hideKeyboard))
            tapToHideKeyboard.numberOfTapsRequired = 1
            self.view?.addGestureRecognizer(tapToHideKeyboard)
        }
    
        @objc func hideKeyboard() {
            self.view.endEditing(true)
        }
    
        @objc func keyboardDidAppear(notification: Notification) {
    
            let screenSize = UIScreen.main.bounds.size
            let keyboardFrame:NSValue = (notification.userInfo! as NSDictionary).value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
            let keyboardHeight = keyboardFrame.cgRectValue.height
            
            self.tableViewBottomConstrant.constant = keyboardHeight + 20
            self.view.layoutIfNeeded()
        }
    
        @objc func keyboardWillHide() {
            
            self.tableViewBottomConstrant.constant = 0
            
            self.view.layoutIfNeeded()

        }
}

extension ChatViewController: BooleanTableCellDelegate, SelectionCellDelegate, SliderCellDelegate, CommentTableViewCellDelegate {
    
    func tappedNumber(input: String) {
        let newMessage = Message(type: .User, text: input)
        ChatHelper.shared.chat.append(newMessage)
        
        FirebaseHelper.share.sendVictimsNumber(value: input) {
            let newMessage = Message(type: .Server, text: "Há vítmas de inconcientes?")
            ChatHelper.shared.chat.append(newMessage)
            ChatHelper.shared.curentImputType = .Boolean
            self.tableView.reloadData()
        }
    }
    
    func tapped(status: Bool) {
        let text = status ? "Sim" : "Não"
        let newMessage = Message(type: .User, text: text)
        ChatHelper.shared.chat.append(newMessage)
        
        if self.locationSended == false{
            self.locationSended = true
            if status == true{
                self.fetchLocationFrom(location: location!)
            }else{
                let newMessage = Message(type: .Server, text: "Quantas vítimas o acidente possui?")
                ChatHelper.shared.chat.append(newMessage)
                ChatHelper.shared.curentImputType = .Selection
                self.tableView.reloadData()
            }
        }else{
            FirebaseHelper.share.sendHasDesmaio(value: status) {
                let newMessage = Message(type: .Server, text: "Qual é o nivel de gravidade do acidente?")
                ChatHelper.shared.chat.append(newMessage)
                ChatHelper.shared.curentImputType = .Slider
                self.tableView.reloadData()
            }
        }
    }
    
    func sendSlideData(value: Int) {
        FirebaseHelper.share.sendGravidade(value: value) {
            let newMessage = Message(type: .Server, text: "obrigado meu pirraia!\n algum comentário sobre a merda que deu?")
            ChatHelper.shared.chat.append(newMessage)
            ChatHelper.shared.curentImputType = .Comment
            self.tableView.reloadData()
        }
    }
    
    func sendComment(comment: String) {
        print(comment)
    }
}
