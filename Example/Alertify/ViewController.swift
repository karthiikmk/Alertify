//
//  ViewController.swift
//  Alertify
//
//  Created by karthikAdaptavant on 01/09/2018.
//  Copyright (c) 2018 karthikAdaptavant. All rights reserved.
//

import UIKit
import Alertify

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.showWelcome()
    }
    
    @IBAction func showAlert(_ sender: UIButton) {
        
        Alertify.alert(title: "Alertify!!", message: "Hello world!")
            .action(.default("OK"))
            .show(on: self)
    }
    
    @IBAction func showActionSheet(_ sender: UIButton) {
        
        Alertify.actionSheet(message: nil, anchorView: sender)
            .action(.default("Chat"), image: #imageLiteral(resourceName: "chat"))
            .action(.default("View"), image: #imageLiteral(resourceName: "info"))
            .action(.default("Info"), image: #imageLiteral(resourceName: "case"))
            .action(.cancel("None"))
            .finally { action, index in
                if action.style == .cancel {
                    return
                }
                Alertify.alert(message: "\(index). \(action.title!)")
                    .action(.default("OK"))
                    .show(on: self)
            }
            .show(on: self)
    }
}

extension ViewController {
    
    func showWelcome() {
        
        Alertify.alert(title: "Alertify", message: "Welcome to Alertify. Its swifty, candy, modern, and awesome.")
            .titleTextColor(UIColor(hex: "6666FF"))
            .messageTextColor(UIColor(hex: "FF6666"))
            .action(.default("😎")) { (action, index, _) in
                print(action, index)
            }
            .action(.default("😀")) { (action, index, _) in
                print(action, index)
            }
            .finally { (action, index, _) in
                print(action, index)
            }
            .show(on: self)
    }
}

extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
