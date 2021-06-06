//
//  ViewController.swift
//  CustomToastView-swift
//
//  Created by lrodriguez@codigodelsur.com on 05/29/2021.
//  Copyright (c) 2021 lrodriguez@codigodelsur.com. All rights reserved.
//

import UIKit
import CustomToastView_swift

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func bottomToTopTapped(_ sender: Any) {
        Toast.Builder()
            .type(.simple)
            .font(UIFont.systemFont(ofSize: 12, weight: .medium))
            .backgroundColor(.blue)
            .textColor(.white)
            .title("Soy un toast!")
            .build()
            .show(viewController: self)
    }
    
    @IBAction func topToBottomTapped(_ sender: Any) {
        //        showToast(with: ToastData())
        
        Toast.Builder()
            .type(.simple)
            .font(UIFont.systemFont(ofSize: 12, weight: .medium))
            .backgroundColor(.magenta)
            .textColor(.white)
            .title("Soy un toast!")
            .orientation(.topToBottom)
            .build()
            .show(viewController: self)
        
    }
    
    @IBAction func leftToRightTapped(_ sender: Any) {
        Toast.Builder()
            .type(.simple)
            .font(UIFont.systemFont(ofSize: 18, weight: .medium))
            .backgroundColor(.customRed)
            .textColor(.white)
            .title("Possible error message!")
            .orientation(.leftToRight)
            .verticalPosition(150)
            .toastHeight(100)
            .build()
            .show(viewController: self)
    }
    
    @IBAction func rightToLeftTapped(_ sender: Any) {
        Toast.Builder()
            .type(.simple)
            .font(UIFont.systemFont(ofSize: 18, weight: .semibold))
            .backgroundColor(.success)
            .textColor(.white)
            .title("Possible success message!")
            .verticalPosition(600)
            .toastHeight(80)
            .orientation(.rightToLeft)
            .build()
            .show(viewController: self)
    }
    
    @IBAction func fadeInTapped(_ sender: Any) {
        Toast.Builder()
            .type(.simple)
            .font(UIFont.systemFont(ofSize: 12, weight: .medium))
            .backgroundColor(.brown)
            .textColor(.white)
            .title("Soy un toast!")
            .verticalPosition(500)
            .orientation(.fadeIn)
            .build()
            .show(viewController: self)
    }
    
    @IBAction func fadeOutTapped(_ sender: Any) {
        Toast.Builder()
            .type(.simple)
            .font(UIFont.systemFont(ofSize: 12, weight: .medium))
            .backgroundColor(.orange)
            .textColor(.white)
            .title("Soy un toast!")
            .orientation(.fadeOut)
            .verticalPosition(400)
            .build()
            .show(viewController: self)
    }
}

extension UIColor {
    static let customRed = UIColor(red: 1.00, green: 0.21, blue: 0.33, alpha: 1.00)
    static let success = UIColor(red: 0.07, green: 0.74, blue: 0.22, alpha: 1.00)
}
