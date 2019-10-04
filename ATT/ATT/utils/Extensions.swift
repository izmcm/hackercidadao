//
//  Extensions.swift
//  ATT
//
//  Created by vinicius emanuel on 04/10/19.
//  Copyright © 2019 hackercidadao. All rights reserved.
//

import Foundation
import UIKit

extension UIView{

    @IBInspectable var cornerRadius: CGFloat {
    get { return layer.cornerRadius }
    set { layer.cornerRadius = newValue }
    }
    
}
