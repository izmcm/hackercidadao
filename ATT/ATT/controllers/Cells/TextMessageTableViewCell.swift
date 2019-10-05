//
//  TextMessageTableViewCell.swift
//  ATT
//
//  Created by vinicius emanuel on 04/10/19.
//  Copyright © 2019 hackercidadao. All rights reserved.
//

import UIKit

// CELULA DE MENSAGENS 
class TextMessageTableViewCell: UITableViewCell {
    @IBOutlet weak var vwUser: UIView!
    @IBOutlet weak var lblMessage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Set visuals for cells buttons etc
        self.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.1843137255, blue: 0.3843137255, alpha: 1)
        self.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
