//
//  LoginViewController.swift
//  DSRE_Example
//
//  Created by Dũng Phạm Tiến  on 5/5/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var btnLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    func configUI() {
        btnLogin.layer.cornerRadius = 12
        btnLogin.clipsToBounds = true
        
    }

    @IBAction func actionLogin(_ sender: Any) {
        if let url = URL(string: "DSREMaster://loginSSO") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Không thể mở app chủ.")
            }
        } else {
            print("Bạn chưa cài app chủ.")
        }
    }
}
