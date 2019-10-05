//
//  CommentTableViewCell.swift
//  ATT
//
//  Created by vinicius emanuel on 05/10/19.
//  Copyright © 2019 hackercidadao. All rights reserved.
//

import UIKit

protocol CommentTableViewCellDelegate {
    func sendComment(comment: String)
}

class CommentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var txtComment: UITextField!
    var delegate: CommentTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtComment.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.1843137255, blue: 0.3843137255, alpha: 1)
        self.txtComment.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func sendTapped(){
        self.delegate?.sendComment(comment: self.txtComment.text ?? "")
    }
    
    @IBAction func notSendTapped(){
        self.delegate?.sendComment(comment: "")
    }
}
