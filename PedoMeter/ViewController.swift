//
//  ViewController.swift
//  PedoMeter
//
//  Created by Abdallah Abdillah on 12/09/2022.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    //CMPedoMeter class allow user to retrieve some information about step taken in the past
    private let activityManger = CMMotionActivityManager()
    private let pedometer = CMPedometer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if CMMotionActivityManager.isActivityAvailable(){
            startTrackingActivityType()
        }
        
        if CMPedometer.isStepCountingAvailable(){
            startStepCount()
        }
        
    }
    
    //tracking activity event
    private func startTrackingActivityType(){
        activityManger.startActivityUpdates(to: OperationQueue.main){
            [weak self](activity:CMMotionActivity?) in
            
            guard let activity = activity else {return}
            DispatchQueue.main.async {
                if activity.walking{
                    print("walking")
                }else if activity.stationary{
                    print("stationary")
                }else if activity.running {
                    print("running")
                }else if activity.automotive{
                    print("Auto motive")
                }
            }
        }
    }
    
    //Method for step counting updates
    private func startStepCount(){
        pedometer.startUpdates(from: Date()){
            [weak self] pedometerData, error in
            guard let pedometerData = pedometerData, error == nil else {return}
            
            DispatchQueue.main.async {
                print(pedometerData.numberOfSteps.stringValue)
            }
        }
    }


}

