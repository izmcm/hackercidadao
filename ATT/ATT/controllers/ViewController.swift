//
//  ViewController.swift
//  ATT
//
//  Created by Izabella Melo on 04/10/19.
//  Copyright © 2019 hackercidadao. All rights reserved.
//

import UIKit
import AVFoundation
import CoreLocation

class ViewController: UIViewController {
    
    let vcCamera = UIImagePickerController()
    var locationManager = CLLocationManager()
    
    var img: UIImage?
    var location: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setButtonsView()
        
        self.vcCamera.delegate = self
        self.vcCamera.allowsEditing = true
        self.vcCamera.sourceType = .camera
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.getLocation()
    }

    @IBAction func btnTakePictureTapped(_ sender: Any) {
        self.openCamera()
    }
    
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    func setButtonsView() {
        self.yesButton.layer.cornerRadius = 25
        self.noButton.layer.cornerRadius = 25
        self.cancelButton.layer.cornerRadius = 25
        
        self.yesButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.yesButton.tintColor = #colorLiteral(red: 0.1450980392, green: 0.1843137255, blue: 0.3843137255, alpha: 1)

        self.noButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)        
        self.noButton.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.1843137255, blue: 0.3843137255, alpha: 1)
        self.noButton.layer.borderWidth = 1
        self.noButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        self.cancelButton.tintColor = #colorLiteral(red: 0.9921568627, green: 0.4862745098, blue: 0.4862745098, alpha: 1)
        self.cancelButton.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.1843137255, blue: 0.3843137255, alpha: 1)
        self.cancelButton.layer.borderWidth = 1
        self.cancelButton.layer.borderColor = #colorLiteral(red: 0.9921568627, green: 0.4862745098, blue: 0.4862745098, alpha: 1)

    }
    
    func getLocation(){
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
                
            case .authorizedWhenInUse, .authorizedAlways:
                locationManager.startUpdatingLocation()
            case .notDetermined:
                locationManager.requestAlwaysAuthorization()
                locationManager.startUpdatingLocation()
            default:
                break
            }
        } else {
            print("Location services are not enabled")
        }
    }
    
    func openCamera(){
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toChatSegue"{
            let vc = segue.destination as! ChatViewController
            vc.img = self.img
            vc.location = self.location
        }
    }
    
}

extension ViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate{
    
    // MARK: - camera
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.vcCamera.dismiss(animated: true, completion: nil)
        
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        
        self.img = image
        
        self.performSegue(withIdentifier: "toChatSegue", sender: nil)
    }
    
    // MARK: - location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location = locations.last
    }
    
}
