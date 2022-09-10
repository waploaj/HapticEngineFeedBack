//
//  ViewController.swift
//  HepticEngine
//
//  Created by Abdallah Abdillah on 10/09/2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManger = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Impact haptic engine feedback
        buttonUiDesign()
        
        //Request User Permission when app is open / background
        locationManger.requestAlwaysAuthorization()
        
        //Request User permissin when the app is open
        locationManger.requestWhenInUseAuthorization()
        
        //if location is enable get the user Location
        if CLLocationManager.locationServicesEnabled(){
            locationManger.delegate = self
            
            //you can change the accurance here
            locationManger.desiredAccuracy = kCLLocationAccuracyBest
            locationManger.startUpdatingLocation()
        }
    }
    
    //Print location coordinate to the console
    func locationManager(_ _manager:CLLocationManager, didUpdateLocations Location:[CLLocation]){
        if let location = Location.first{
            print(location.coordinate)
        }
        
    }
    
    //if we have been denied access give a user the option to change it
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.denied{
            showLocationDisablePopUp()
        }
    }
    
    //Show the popup to the user if we have been denied
    func showLocationDisablePopUp(){
        let alertControler = UIAlertController(title: "Background Location Access Disable", message: "Inorder to function we need LocationServices", preferredStyle: .alert)
        
        let alertCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertControler.addAction(alertCancel)
        
        let openAction  = UIAlertAction(title: "Open Setting", style: .default){(action) in
            if let url = URL(string: UIApplication.openSettingsURLString){
                UIApplication.shared.open(url, options: [:],completionHandler: nil)
            }
        }
        
        alertControler.addAction(openAction)
        self.present(alertControler, animated: true, completion: nil)
    }
    
    
    
    //Notification Using Haptic Engine when clicked.
    @objc func buttonClicked(sender:UIButton){
//        let alert = UIAlertController(title: "clicked", message: "you have clicked the button", preferredStyle: .alert)
//        self.present(alert, animated: true, completion:nil)
        
        let impact = UIImpactFeedbackGenerator()
        impact.impactOccurred()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func buttonUiDesign(){
        let buttonX = 150
        let buttonY = 150
        let buttonHeight = 50
        let buttonWidth = 100
        
        let button = UIButton(type: .system)
        button.setTitle("Click me!!", for: .normal)
        button.tintColor = .blue
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        
        button.frame = CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight)
        
        self.view.addSubview(button)
        
    }


}

