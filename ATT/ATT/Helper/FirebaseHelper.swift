//
//  FirebaseHelper.swift
//  ATT
//
//  Created by vinicius emanuel on 04/10/19.
//  Copyright © 2019 hackercidadao. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class FirebaseHelper {
    static let share = FirebaseHelper()
    var id: String?
    
    private var db: Firestore!
    
    init() {
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
    }
    
    func sendImage(image: UIImage, block: @escaping (()->Void)){
        
        self.id = NSUUID().uuidString
        
        let imgBase64 = self.convertImageToBase64(image)
        
        self.db.collection("Occurrence").document(self.id!).setData([
            "image" : imgBase64,
            "time": Date().timeIntervalSince1970,
            "flag": 0
        ]) { (error) in
            if error == nil{
                block()
            }
        }
    }
    
    func sendAdress(cidade: String, bairro: String, rua: String, numero: String, lat: Double, lon: Double, block: @escaping (()->Void)){
        self.db.collection("Occurrence").document(self.id!).updateData([
        "cidade": cidade,
        "bairro": bairro,
        "rua": rua,
        "numero": numero,
        "lat": lat,
        "lon": lon
        ]) { (error) in
            if error == nil{
                block()
            }
        }
    }
    
    func sendVictimsNumber(value: String, block: @escaping (()->Void)){
        self.db.collection("Occurrence").document(self.id!).updateData([
        "Victims_number": value
        ]) { (error) in
            if error == nil{
                block()
            }
        }
    }
    
    func sendHasDesmaio(value: Bool, block: @escaping (()->Void)){
        self.db.collection("Occurrence").document(self.id!).updateData([
        "desmaio": value
        ]) { (error) in
            if error == nil{
                block()
            }
        }
    }
    
    func sendGravidade(value: Int, block: @escaping (()->Void)){
        self.db.collection("Occurrence").document(self.id!).updateData([
        "gravidade": value
        ]) { (error) in
            if error == nil{
                block()
            }
        }
    }
    
    private func convertImageToBase64(_ image: UIImage) -> String {
        let imageData:NSData = image.jpegData(compressionQuality: 0.4)! as NSData
           let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
           return strBase64
    }
    
}
