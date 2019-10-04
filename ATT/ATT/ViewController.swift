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
        self.opeCamera()
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
