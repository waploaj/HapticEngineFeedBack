//
//  ViewController.swift
//  HepticEngine
//
//  Created by Abdallah Abdillah on 10/09/2022.
//

import UIKit
import CoreLocation
import CoreMotion
import Alamofire


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    
    let locationManger = CLLocationManager()
    let p = ButtonDesign()
    private let activityManger = CMMotionActivityManager()
    private let pedoMeter =  CMPedometer()
    
    
    
    @IBOutlet weak var coordinate: UILabel!
    
    @IBOutlet weak var altitude: UILabel!
    @IBOutlet weak var speed: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        coordinate.adjustsFontSizeToFitWidth = true
        
        
        
        let parameter = ["appVersion": "1.3.1",
                         "countryCode": "TZ",
                         "deviceName": "chrome",
                         "deviceId": "Web",
                         "deviceOS": "Mac OS",
                         "deviceToken": "token",
                         "mobileNumber": "+255710886014",
                         "password": "123456"]
        AF.request("https://azamtvmax.com/api/login",method: .post,parameters: parameter).response{
            response in
            //debugPrint(response)
        }
        
        
        //Impact haptic engine feedback
        self.view.addSubview(p.buttonUiDesign())
        
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
            coordinate.text = "Your location \(location.coordinate.latitude.description) \(location.coordinate.longitude.description) - \(location.timestamp.description)"
            speed.text = "Your moving at speed of \(location.speed.description) course \(location.courseAccuracy.description)"
            altitude.text = "Your at altitude of \(location.altitude.description)"
            
            let object  =  CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            print(object.description)
            
            print(object.distance(from: object))
            
            
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //TODO:Monitor user aproximity to geographical position.
    //TODO:SensorKit
    

}

