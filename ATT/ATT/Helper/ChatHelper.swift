//
//  ChatHelper.swift
//  ATT
//
//  Created by vinicius emanuel on 04/10/19.
//  Copyright © 2019 hackercidadao. All rights reserved.
//

import Foundation

enum MessageFrom{
    case User
    case Server
}

enum ImputType{
    case Boolean
    case Selection
    case Slider
}

class Message{
    var type: MessageFrom
    var text: String
    
    init(type: MessageFrom, text: String) {
        self.type = type
        self.text = text
    }
}

class ChatHelper {
    
    static let shared = ChatHelper()
    
    var chat: [Message] = []
    var curentImputType: ImputType? = nil
    
}
