//
//  ViewController.swift
//  DSRE
//
//  Created by anhdungaxz on 03/29/2024.
//  Copyright (c) 2024 anhdungaxz. All rights reserved.
//

import UIKit
import DSRE

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let a = DSRE.share.add(a: 1, b: 1)
        print(a)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

