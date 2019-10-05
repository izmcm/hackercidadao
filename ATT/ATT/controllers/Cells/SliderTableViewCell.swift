//
//  SliderTableViewCell.swift
//  ATT
//
//  Created by vinicius emanuel on 04/10/19.
//  Copyright © 2019 hackercidadao. All rights reserved.
//

import UIKit

protocol SliderCellDelegate {
    func sendSlideData(value: Int)
}

// SLIDER PARA SETAR NÍVEL DE GRAVIDADE DA SITUACAO
class SliderTableViewCell: UITableViewCell {
    @IBOutlet weak var btnSend: UIButton!
    
    @IBOutlet weak var slider: UISlider!
    
    var delegate: SliderCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Set visuals for cells buttons etc
        self.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.1843137255, blue: 0.3843137255, alpha: 1)
        self.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        self.slider.minimumTrackTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.slider.maximumTrackTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        self.btnSend.tintColor = #colorLiteral(red: 0.1450980392, green: 0.1843137255, blue: 0.3843137255, alpha: 1)
        self.btnSend.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.btnSend.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.btnSend.layer.borderWidth = 1
        self.btnSend.layer.cornerRadius = 30
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func btnSendTapped(_ sender: Any) {
        self.delegate?.sendSlideData(value: Int(self.slider.value))
    }
}
