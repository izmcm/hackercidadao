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
        
        self.db.collection("Occurrence").document(self.id!).setData(["image" : imgBase64]) { (error) in
            if error == nil{
                block()
            }
        }
    }
    
    func sendAdress(cidade: String, bairro: String, rua: String, numero: String){
        self.db.collection("Occurrence").document(self.id!).setData([
        "cidade": cidade,
        "bairro": bairro,
        "rua": rua,
        "numero": numero
        ]) { (error) in
            if error == nil{
                print("deu bom")
            }
        }
    }
    
    private func convertImageToBase64(_ image: UIImage) -> String {
        let imageData:NSData = image.jpegData(compressionQuality: 0.4)! as NSData
           let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
           return strBase64
    }
    
}
