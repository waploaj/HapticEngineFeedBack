//
//  ViewController.swift
//  HepticEngine
//
//  Created by Abdallah Abdillah on 10/09/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
    
    let impact = UIImpactFeedbackGenerator()
    
    @objc func buttonClicked(sender:UIButton){
        let alert = UIAlertController(title: "clicked", message: "you have clicked the button", preferredStyle: .alert)
        self.present(alert, animated: true, completion:nil)
        
        impact.impactOccurred()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

