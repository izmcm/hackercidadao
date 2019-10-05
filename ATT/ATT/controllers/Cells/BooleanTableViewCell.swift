//
//  BooleanTableViewCell.swift
//  ATT
//
//  Created by vinicius emanuel on 04/10/19.
//  Copyright © 2019 hackercidadao. All rights reserved.
//

import UIKit

protocol BooleanTableCellDelegate {
    func tappedYes()
}

class BooleanTableViewCell: UITableViewCell {
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    
    var delegate: BooleanTableCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func btnNoTapped(_ sender: Any) {
    }
    
    @IBAction func btnYesTapped(_ sender: Any) {
        delegate?.tappedYes()
    }
}
