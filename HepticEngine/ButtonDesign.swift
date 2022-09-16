//
//  ButtonDesign.swift
//  HepticEngine
//
//  Created by Abdallah Abdillah on 10/09/2022.
//

import Foundation
import UIKit
class ButtonDesign:UIButton{
    func buttonUiDesign() -> UIButton{
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
        button.isHidden = true
        
        return button
        
    }
    
    //Notification Using Haptic Engine when clicked.
    @objc func buttonClicked(){
//        let alert = UIAlertController(title: "clicked", message: "you have clicked the button", preferredStyle: .alert)
//        self.present(alert, animated: true, completion:nil)
        
        let impact = UIImpactFeedbackGenerator()
        impact.impactOccurred()
        
        
        
    }
    
    func textLableDesign() -> UILabel {
        let textLabel = UILabel()
        textLabel.font = UIFont.preferredFont(forTextStyle: .body)
        textLabel.backgroundColor = .yellow
        textLabel.numberOfLines = 0
        return textLabel
    }
}
