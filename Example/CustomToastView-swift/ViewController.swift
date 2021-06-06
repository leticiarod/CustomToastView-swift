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
            .font(UIFont.systemFont(ofSize: 12, weight: .medium))
            .backgroundColor(.blue)
            .textColor(.white)
            .title("Hello! I'm a toast")
            .build()
            .show(on: self)
    }
    
    @IBAction func topToBottomTapped(_ sender: Any) {
        Toast.Builder()
            .font(UIFont.systemFont(ofSize: 12, weight: .medium))
            .backgroundColor(.magenta)
            .textColor(.white)
            .title("Hello! I'm a toast")
            .orientation(.topToBottom)
            .rightActionLabel("UNDO")
            .actionFont(UIFont.systemFont(ofSize: 12, weight: .medium))
            .actionTextColor(.white)
            .build()
            .show(on: self, actionCompletion: {
                print("UNDO action tapped")
            })
    }
    
    @IBAction func leftToRightTapped(_ sender: Any) {
        Toast.Builder()
            .font(UIFont.systemFont(ofSize: 18, weight: .medium))
            .backgroundColor(.customRed)
            .textColor(.white)
            .title("Possible error message!")
            .orientation(.leftToRight)
            .verticalPosition(150)
            .toastHeight(100)
            .build()
            .show(on: self)
    }
    
    @IBAction func rightToLeftTapped(_ sender: Any) {
        Toast.Builder()
            .font(UIFont.systemFont(ofSize: 18, weight: .semibold))
            .backgroundColor(.success)
            .showLeftIcon(UIImage(named: "check"))
            .textColor(.white)
            .title("Possible success message!")
            .verticalPosition(600)
            .toastHeight(80)
            .orientation(.rightToLeft)
            .textAlignment(.left)
            .build()
            .show(on: self)
    }
    
    @IBAction func fadeInTapped(_ sender: Any) {
        Toast.Builder()
            .font(UIFont.systemFont(ofSize: 12, weight: .semibold))
            .backgroundColor(.brown)
            .textColor(.white)
            .title("Hello! I'm a toast")
            .verticalPosition(500)
            .orientation(.fadeIn)
            .textAlignment(.left)
            .build()
            .show(on: self)
    }
    
    @IBAction func fadeOutTapped(_ sender: Any) {
        Toast.Builder()
            .font(UIFont.systemFont(ofSize: 12, weight: .semibold))
            .backgroundColor(.orange)
            .textColor(.white)
            .title("Hello! I'm a toast")
            .orientation(.fadeOut)
            .verticalPosition(400)
            .textAlignment(.right)
            .timeDismissal(1)
            .build()
            .show(on: self)
    }
    
    @IBAction func dismissByTapping(_ sender: Any) {
        Toast.Builder()
            .font(UIFont.systemFont(ofSize: 12, weight: .medium))
            .backgroundColor(.blue)
            .textColor(.white)
            .title("Hello! I'm a toast")
            .shouldDismissAfterPresenting(false)
            .build()
            .show(on: self) { toast in
                toast.hide()
            }
    }
}

extension UIColor {
    static let customRed = UIColor(red: 1.00, green: 0.21, blue: 0.33, alpha: 1.00)
    static let success = UIColor(red: 0.07, green: 0.74, blue: 0.22, alpha: 1.00)
}
