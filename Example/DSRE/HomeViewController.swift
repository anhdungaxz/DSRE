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
    var isloginChild: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbWelcome.text = "Chào mừng " + (loginPhone ?? "") + "đến với dịch vụ của VNPT"
        if isloginChild {
            alertLoginChild()
        }
    }

    @IBAction func actionLogout(_ sender: Any) {
        AppDelegate.shared.loginPhone = nil
        let navi = UINavigationController(rootViewController: LoginViewController())
        navi.isNavigationBarHidden = true
        AppDelegate.shared.window?.rootViewController = navi
    }
    
    func alertLoginChild() {
        let vc = UIAlertController(title: "Đăng nhập", message: "Bạn có muốn đăng nhập dịch vụ trên app con không?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Có", style: .default) { _ in
            if let url = URL(string: "DSREChild://loginSSO?phone=" + (self.loginPhone ?? "")) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    print("Không thể mở app con.")
                }
            } else {
                print("Bạn chưa cài app con.")
            }
        }
        let noAction = UIAlertAction(title: "Không", style: .cancel)
        vc.addAction(yesAction)
        vc.addAction(noAction)
        self.present(vc, animated: true)
        
    }

}
