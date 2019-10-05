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
                
                if locationSended == false {
                    cell.btnNo.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    cell.btnNo.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.1843137255, blue: 0.3843137255, alpha: 1)
                    cell.btnNo.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    cell.btnNo.layer.borderWidth = 1
                    cell.btnNo.layer.cornerRadius = 22
                    
                    cell.btnYes.tintColor = #colorLiteral(red: 0.1450980392, green: 0.1843137255, blue: 0.3843137255, alpha: 1)
                    cell.btnYes.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    cell.btnYes.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    cell.btnYes.layer.borderWidth = 1
                    cell.btnYes.layer.cornerRadius = 22     
                } else {
                    cell.btnYes.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    cell.btnYes.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.1843137255, blue: 0.3843137255, alpha: 1)
                    cell.btnYes.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    cell.btnYes.layer.borderWidth = 1
                    cell.btnYes.layer.cornerRadius = 22
                    
                    cell.btnNo.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    cell.btnNo.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.1843137255, blue: 0.3843137255, alpha: 1)
                    cell.btnNo.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    cell.btnNo.layer.borderWidth = 1
                    cell.btnNo.layer.cornerRadius = 22
                }
                
                
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
                cell.txtComment.delegate = self
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
            
            self.tableViewBottomConstrant.constant = keyboardHeight
            self.view.layoutIfNeeded()
        }
    
        @objc func keyboardWillHide() {
            
            self.tableViewBottomConstrant.constant = 0
            
            self.view.layoutIfNeeded()

        }
}

extension ChatViewController: BooleanTableCellDelegate, SelectionCellDelegate, SliderCellDelegate, CommentTableViewCellDelegate, UITextFieldDelegate {
    
    func tappedNumber(input: String) {
        let newMessage = Message(type: .User, text: input)
        ChatHelper.shared.chat.append(newMessage)
        
        FirebaseHelper.share.sendVictimsNumber(value: input) {
            let newMessage = Message(type: .Server, text: "Há vítimas inconscientes?")
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
                let newMessage = Message(type: .Server, text: "Quantas vítimas teve o acidente?")
                ChatHelper.shared.chat.append(newMessage)
                ChatHelper.shared.curentImputType = .Selection
                self.tableView.reloadData()
            }
        }else{
            FirebaseHelper.share.sendHasDesmaio(value: status) {
                let newMessage = Message(type: .Server, text: "Qual é o nível de gravidade do acidente?")
                ChatHelper.shared.chat.append(newMessage)
                ChatHelper.shared.curentImputType = .Slider
                self.tableView.reloadData()
            }
        }
    }
    
    func sendSlideData(value: Int) {
        FirebaseHelper.share.sendGravidade(value: value) {
            let newMessage = Message(type: .Server, text: "Obrigado! Você tem algum comentário a acrescentar?")
            ChatHelper.shared.chat.append(newMessage)
            ChatHelper.shared.curentImputType = .Comment
            self.tableView.reloadData()
        }
    }
    
    func sendComment(comment: String) {
        FirebaseHelper.share.sendComment(comment: comment) {
            self.performSegue(withIdentifier: "daleSegue", sender: nil)
        }
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        FirebaseHelper.share.sendComment(comment: scoreText.text ?? "") {
            self.performSegue(withIdentifier: "daleSegue", sender: nil)
        }
        self.view.endEditing(true)
        return true
    }
}
