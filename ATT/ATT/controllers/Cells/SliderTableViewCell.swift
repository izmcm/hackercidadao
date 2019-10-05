//
//  SliderTableViewCell.swift
//  ATT
//
//  Created by vinicius emanuel on 04/10/19.
//  Copyright © 2019 hackercidadao. All rights reserved.
//

protocol SliderCellDelegate {
    func sendSlideData(value: Int)
}

import UIKit

class SliderTableViewCell: UITableViewCell {
    @IBOutlet weak var btnSend: UIButton!
    
    @IBOutlet weak var slider: UISlider!
    
    var delegate: SliderCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func btnSendTapped(_ sender: Any) {
        self.delegate?.sendSlideData(value: Int(self.slider.value))
    }
}
