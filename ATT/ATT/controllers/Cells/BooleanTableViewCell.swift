//
//  BooleanTableViewCell.swift
//  ATT
//
//  Created by vinicius emanuel on 04/10/19.
//  Copyright © 2019 hackercidadao. All rights reserved.
//

import UIKit

// BOTOES DE SIM OU NAO 
protocol BooleanTableCellDelegate {
    func tapped(status: Bool)
}

class BooleanTableViewCell: UITableViewCell {
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    
    var delegate: BooleanTableCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Set visuals for cells buttons etc
        self.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.1843137255, blue: 0.3843137255, alpha: 1)
        self.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        self.btnNo.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.btnNo.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.1843137255, blue: 0.3843137255, alpha: 1)
        self.btnNo.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.btnNo.layer.borderWidth = 1
        self.btnNo.layer.cornerRadius = 30
        
        
        self.btnYes.tintColor = #colorLiteral(red: 0.1450980392, green: 0.1843137255, blue: 0.3843137255, alpha: 1)
        self.btnYes.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.btnYes.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.btnYes.layer.borderWidth = 1
        self.btnYes.layer.cornerRadius = 30


        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func btnNoTapped(_ sender: Any) {
        delegate?.tapped(status: false)
        
    }
    
    @IBAction func btnYesTapped(_ sender: Any) {
        delegate?.tapped(status: true)
 
    }
}
