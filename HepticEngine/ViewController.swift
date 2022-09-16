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
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    
    let locationManger = CLLocationManager()
    let p = ButtonDesign()
    private let activityManger = CMMotionActivityManager()
    private let pedoMeter =  CMPedometer()
    var lastCoordinate:CLLocationCoordinate2D?
    var latitude:CLLocationDegrees?
    var longitude:CLLocationDegrees?
    
    
    
    
    
    //UI outlet
    @IBOutlet weak var coordinate: UILabel!
    @IBOutlet weak var mapKIT: MKMapView!
    var counter = 0
    @IBOutlet weak var SwitchMaps: UILabel!
    @IBOutlet weak var altitude: UILabel!
    @IBOutlet weak var speed: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //adjust the widht to fit the size
        coordinate.adjustsFontSizeToFitWidth = true
       
        
        //UILabel call a function to perform an action when tap
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.labelAction(_:)))
            coordinate.addGestureRecognizer(tap)
            coordinate.isUserInteractionEnabled = true
        
        let taps = UITapGestureRecognizer(target: self, action: #selector(self.labelSwitchMaps(_:)))
        SwitchMaps.addGestureRecognizer(taps)
        SwitchMaps.isUserInteractionEnabled = true
            
        
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
            coordinate.text = "Your location \(location.coordinate.latitude.description) \(location.coordinate.longitude.description) - \(location.timestamp.description) "
            speed.text = "Your moving at speed of \(location.speed.description) course \(location.courseAccuracy.description)"
            altitude.text = "Your at altitude of \(location.altitude.description )"

            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
        }
        
    }
    @objc func labelSwitchMaps(_ sender:UIGestureRecognizer){
        let impact = UIImpactFeedbackGenerator()
        impact.impactOccurred()
        if counter == 1{
            mapKIT.mapType = MKMapType.standard
            counter = 0
        }else if counter == 0 {
            mapKIT.mapType = MKMapType.satellite
            counter = 1
        }
       
    }
    
    @objc func labelAction(_ sender: UIGestureRecognizer) {
        //Haptic Engine
        let impact = UIImpactFeedbackGenerator()
        impact.impactOccurred()
        
        let regionDistance:CLLocationDistance = 1000
        let coordinates = CLLocationCoordinate2DMake((latitude)!, (longitude)!)
        let regionSpant = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
//        let option = [
//            MKLaunchOptionsMapCenterKey:NSValue(mkCoordinate: regionSpant.center),
//            MKLaunchOptionsMapSpanKey:NSValue(mkCoordinateSpan: regionSpant.span)
//        ]
        let placeMark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
 //       let mapItem = MKMapItem(placemark: placeMark)
        
//        mapItem.name = "You are Here"
//        mapItem.openInMaps(launchOptions: option)
        mapKIT.addAnnotation(placeMark)
        mapKIT.isZoomEnabled = true
        
        mapKIT.setRegion(regionSpant, animated: true)
        mapKIT.layer.name = "You are here"
        if counter == 0{
            mapKIT.mapType = MKMapType.satellite
            counter = 1
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

