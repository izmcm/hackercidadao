//
//  SelectionTableViewCell.swift
//  ATT
//
//  Created by vinicius emanuel on 04/10/19.
//  Copyright © 2019 hackercidadao. All rights reserved.
//

import UIKit

protocol SelectionCellDelegate {
    func tappedNumber(input: String)
}

// SEGMENTED CONTROL PARA SELECIONAR A QUANTIDADE DE VITIMAS
class SelectionTableViewCell: UITableViewCell {
    @IBOutlet weak var selectionSegment: UISegmentedControl!
    
    var delegate: SelectionCellDelegate?
    
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

    @IBAction func indexChanged(_ sender: Any) {
        
        switch selectionSegment.selectedSegmentIndex
        {
        case 0:
            delegate?.tappedNumber(input: "1")
        case 1:
            delegate?.tappedNumber(input: "2")
        case 2:
            delegate?.tappedNumber(input: "3")
        case 3:
            delegate?.tappedNumber(input: "4-6")
        case 4:
            delegate?.tappedNumber(input: "7-9")
        case 5:
            delegate?.tappedNumber(input: "10+")
        default:
            break
        }
    }
    
}
