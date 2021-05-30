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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showToast(with: .simple)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func showToast(_ sender: Any) {
        showToast(with: .simple)
    }
}

