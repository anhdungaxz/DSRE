//
//  HomeViewController.swift
//  DSRE_Example
//
//  Created by Dũng Phạm Tiến  on 19/5/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var lbWelcome: UILabel!
    
    var loginPhone: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbWelcome.text = "Chào mừng " + (loginPhone ?? "") + "đến với dịch vụ của VNPT"
        // Do any additional setup after loading the view.
    }

    @IBAction func actionLogout(_ sender: Any) {
        let navi = UINavigationController(rootViewController: LoginViewController())
        navi.isNavigationBarHidden = true
        AppDelegate.shared.window?.rootViewController = navi
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
