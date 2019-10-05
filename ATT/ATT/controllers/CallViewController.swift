//
//  CallViewController.swift
//  ATT
//
//  Created by Penélope Araújo on 05/10/19.
//  Copyright © 2019 hackercidadao. All rights reserved.
//

import UIKit

class CallViewController: UIViewController {

    @IBOutlet weak var labelObrigado: UILabel!
    
    @IBOutlet weak var buttonLigar: UIButton!
    @IBOutlet weak var buttonFinalizar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.buttonLigar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.buttonLigar.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.1843137255, blue: 0.3843137255, alpha: 1)
        self.buttonLigar.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.buttonLigar.layer.borderWidth = 1
        self.buttonLigar.layer.cornerRadius = 22
        
        self.buttonFinalizar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.buttonFinalizar.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.1843137255, blue: 0.3843137255, alpha: 1)
        self.buttonFinalizar.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.buttonFinalizar.layer.borderWidth = 1
        self.buttonFinalizar.layer.cornerRadius = 22

    }
    

    @IBAction func buttonLigarTapped(_ sender: Any) {
        if let url = URL(string: "tel://192"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    @IBAction func buttonFinalizarTapped(_ sender: Any) {
        ChatHelper.shared.chat = []
        ChatHelper.shared.curentImputType = nil
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
