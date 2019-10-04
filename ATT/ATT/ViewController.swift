//
//  ViewController.swift
//  ATT
//
//  Created by Izabella Melo on 04/10/19.
//  Copyright © 2019 hackercidadao. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let vcCamera = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.vcCamera.delegate = self
        self.vcCamera.allowsEditing = true
        self.vcCamera.sourceType = .camera
    }

    @IBAction func btnTakePictureTapped(_ sender: Any) {
        self.opeCamera()
    }
    
    func opeCamera(){
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
        case .authorized:
            self.present(self.vcCamera, animated: true, completion: nil)
        case .denied:
            print("negada")
        default:
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { granted in
                if granted {
                    self.present(self.vcCamera, animated: true, completion: nil)
                } else {
                    print("Denied access ")
                }
            })
            return
        }
    }
    
}

extension ViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.vcCamera.dismiss(animated: true, completion: nil)
        
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        
        print(image.size)
    }
}
