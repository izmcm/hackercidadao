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
    
    private var db: Firestore!
    
    init() {
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
    }
}
