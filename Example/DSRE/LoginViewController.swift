//
//  LoginViewController.swift
//  DSRE_Example
//
//  Created by Dũng Phạm Tiến  on 5/5/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import DSRE
import SVProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var vBoundInput: UIView!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var vIcon4g: UIView!
    
    var isLoginChild: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    func configUI() {
        vBoundInput.layer.cornerRadius = 12
        vBoundInput.clipsToBounds = true
        vBoundInput.layer.borderWidth = 1
        vBoundInput.layer.borderColor = UIColor(white: 0.7, alpha: 1.0).cgColor
        btnLogin.layer.cornerRadius = 12
        btnLogin.clipsToBounds = true
        vIcon4g.layer.cornerRadius = vIcon4g.frame.size.width/2
        vIcon4g.clipsToBounds = true
        vIcon4g.layer.borderWidth = 1
        vIcon4g.layer.borderColor = UIColor(white: 0.7, alpha: 1.0).cgColor
        tfPhone.attributedPlaceholder = NSAttributedString(
            string: "+84 (096) 453-2407",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 0.7, alpha: 1.0)]
        )
    }

    @IBAction func actionLogin(_ sender: Any) {
        SVProgressHUD.show()
        DSRE.share.fetchOtp(msisdn: tfPhone.text ?? "") { responseCode, otpID, otp in
            SVProgressHUD.dismiss()
            if responseCode.code == 0 {
                ToastView.showToast(type: .success, message: "OTP: " + (otp ?? ""))
                let vc = OTPViewController()
                vc.otpId = otpID
                vc.msisdn = self.tfPhone.text ?? ""
                self.navigationController?.pushViewController(vc)
            } else {
                ToastView.showToast(type: .error, message: responseCode.message ?? "")
            }
        }
    }
    
    @IBAction func actionLogin4g(_ sender: Any) {
        SVProgressHUD.show()
        DSRE.share.loginViaCellular { responseCode, authen in
            SVProgressHUD.dismiss()
            if responseCode.code == 0 {
        let phone = authen?.msisdn
                AppDelegate.shared.loginPhone = phone
                let vc = HomeViewController()
                vc.loginPhone = phone
        vc.isloginChild = false
                self.navigationController?.pushViewController(vc)
                
            } else {
                ToastView.showToast(type: .error, message: responseCode.message ?? "")
            }
        }
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
