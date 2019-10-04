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
    
    func sendAdress(cidade: String, bairro: String, rua: String, numero: String){
        self.id = NSUUID().uuidString
        
        self.db.collection("Occurrence").document(self.id!).setData([
        "cidade":cidade,
        "bairro":bairro,
        "rua":rua,
        "numero":numero
        ]) { (error) in
            print(error?.localizedDescription)
        }
    }
    
}
